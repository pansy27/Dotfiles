local beautiful = require("beautiful")
local gears = require("gears")
-- set theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/cinnamonroll/theme.lua")
