local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")

awesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "lock", function () awful.spawn.with_shell("~/.scripts/lock.sh") end },
   { "quit", function() awesome.quit() end },
   { "shutdown", function () awesome.spawn("shutdown now") end },
   { "reboot", function () awesome.spawn("systemctl reboot") end },
}

mainmenu = awful.menu({ items = { { "awesome", awesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mainmenu })
