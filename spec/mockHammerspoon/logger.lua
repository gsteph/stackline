
-- NOTE: 
--90 Line log module with color output & file-writing
--https://github.com/rxi/log.lua/blob/master/log.lua

-- Stackline use:
-- hs.logger.new(level)
--    log.setLogLevel('info')
--    log.i(msg), etc

-- local log = hs.logger.new('hsmock.logger')
-- log.setLogLevel('info')
-- log.i("Loading'hsmock.logger")

local logger = {}

logger.levels = {
  ['nothing'] = 0,
  ['error']   = 1,
  ['warning'] = 2,
  ['info']    = 3,
  ['debug']   = 4,
  ['verbose'] = 5,
}

logger.level = 1

local function parseLevel(lvl)
  if type(lvl)=='number' then
    return lvl
  elseif type(lvl)=='string' then
    return tonumber(logger.levels[lvl])
  else
    error("Can't parse logger level")
  end
end

function logger.new(name, level)
  local l = {
    level = level,
    e = function(v) if logger.level >= 1 then log.d(name, v) end end,
    w = function(v) if logger.level >= 2 then log.d(name, v) end end,
    i = function(v) if logger.level >= 3 then log.d(name, v) end end,
    d = function(v) if logger.level >= 4 then log.d(name, v) end end,
    v = function(v) if logger.level >= 5 then log.d(name, v) end end,
    setLogLevel = function() end,
    getLogLevel = function() end,
  }
  l.level = logger.level
  setmetatable(l, logger)
  logger.__index = logger
  return l
end

-- TODO: cleanup these nasty conditionals in logger.setLogLevel
function logger.setLogLevel(self, nl)
  if type(self)=='number' and nl==nil then
    nl = self
  elseif type(self)=='table' and nl ~= nil then
    self.level = parseLevel(nl)
  elseif nl ~= nil then
    logger.level = parseLevel(nl)
  else
    error(string.format("Can't set logger level with %s or %s", self, nl))
  end
end

function logger:getLogLevel()
  return self.level
end

return logger