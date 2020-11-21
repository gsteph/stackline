local async = require 'stackline.lib.async'

describe('#module #stackmanager', function()

  before_each(function()
    require 'lib.updatePackagePath'
    _G.hs = helpers.reloadMock()
    fixture = require 'spec.fixtures.load'()
    hs.window.filter:set(fixture.screen.windows)
    hs.task:set(fixture.stackIndexes)
    stackline = require 'stackline.stackline'
    stackline.config = require 'stackline.configManager'
  end)

  it('initially nil', function()
    assert.is_nil(stackline.manager)
  end)

  describe('init()', function()

    before_each(function()
      stackline:init()
    end)

    it('works', function()
      assert.is_table(stackline.manager)
      assert.is_boolean(stackline.manager.showIcons)
    end)

    it('callable methods', function()
      assert.is_function(stackline.manager.get)
      assert.is_function(stackline.manager.ingest)
    end)

    it('update()', function()
      local ws = stackline.wf:getWindows()
      stackline.manager:update()
      assert.greater_than(0, #stackline.manager.tabStacks)
    end)

    it('correct num stacks', function()
      assert.equals(fixture.summary.numStacks, #stackline.manager.tabStacks)
    end)

    it('getSummary()', function()
      assert.is_table(stackline.manager:getSummary())
    end)

    it('correct stacks/wins', function()
      local summary = stackline.manager:getSummary()
      summary.topLeft = nil -- TODO: consider removing 'topLeft'. It's pretty unnecessary
      assert.deepEqual(summary, fixture.summary)
    end)

  end)

  describe('finds', function()

    it('window', function()
      local win_id = stackline.manager:get()[1].windows[1].id
      local win = stackline.manager:findWindow(win_id)
      assert.is_table(win)
    end)

    it('stack by window', function()
      local dimensionsFzy = fixture.summary.dimensionsFzy

      -- query window
      local win = stackline.manager:get()[1].windows[1]
      local stack = stackline.manager:findStackByWindow(win)

      -- verify result
      assert.is_table(stack)
      assert.contains(dimensionsFzy, stack.id)
    end)


  end)

end)
