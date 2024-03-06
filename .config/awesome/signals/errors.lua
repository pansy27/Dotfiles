local beautiful = require("beautiful")
local naughty = require("naughty")
local gfs = require("gears.filesystem")

-- Error notifs
naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
		bg = beautiful.colors.silly_fg,
		fg = beautiful.colors.silly_bg,
		icon = gfs.get_configuration_dir() .. "themes/cinnamonroll/" .. "error.svg",
		icon_size = 32,
		timeout = 0
	})
end)
