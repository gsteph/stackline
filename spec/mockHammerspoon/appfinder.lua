


-- FROM: stackline.window
-- appBundle = hs.appfinder.appFromName(self.app):bundleID()
-- return hs.image.imageFromAppBundle(appBundle)

local application = require 'stackline.tests.mockHammerspoon.application'

local appfinder = {}


appfinder.appFromName = function(appName)
  return application:new()
end

return appfinder