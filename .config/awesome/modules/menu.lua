local awful = require("awful")
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

mainmenu = awful.menu({ items = { { "awesome", awesomemenu, "/home/rider/Desktop/cherry.png" },
                                    { "open terminal", terminal }
                                  }
                        })

launcher = awful.widget.launcher({ image = "/home/rider/Desktop/cherry.png",
                                     menu = mainmenu })
