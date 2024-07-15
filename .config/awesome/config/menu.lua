local awful = require("awful")
local apps = require("config.apps")
local beautiful = require("beautiful")
local menubar = require("menubar")

-- Create a launcher widget and a main menu
local myawesomemenu = {{"hotkeys", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
end}, {"manual", apps.terminal .. " -e man awesome"}, {"edit config", apps.editor_cmd .. " " .. awesome.conffile},
                       {"restart", awesome.restart}, {"quit", function()
    awesome.quit()
end}, {"lock screen", function()
    awful.spawn.with_shell("loginctl lock-session")
end}, {"poweroff", function()
    awful.spawn.with_shell("systemctl poweroff")
end}, {"reboot", function()
    awful.spawn.with_shell("systemctl reboot")
end}, {"hibernate", function()
    awful.spawn.with_shell("sleep 2 && loginctl lock-session | systemctl hibernate")
end}}

mymainmenu = awful.menu({
    items = {{"awesome", myawesomemenu, beautiful.awesome_icon}, {"Applications", xdgmenu},
             {"open terminal", apps.terminal}}
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = apps.terminal -- Set the terminal for applications that require it
-- }}}
