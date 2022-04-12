local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

require "modules/menu"

-- Wibar configuration
tbox_separator_alt = wibox.widget.textbox("  ")
tbox_separator = wibox.widget.textbox("    ")
l_sep = wibox.widget.textbox(" [ ")
m_sep = wibox.widget.textbox(" ][ ")
r_sep = wibox.widget.textbox(" ] ")
-- Clock widget
mytextclock = wibox.widget{
        format = '  %d,   %H:%M ',
        widget = wibox.widget.textclock
        }

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s)
    --, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
--           awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
--           awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        bg = "#f9fbff",
        fg = "#d1beef",
        height = 32,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                tbox_separator_alt,
                launcher,
                tbox_separator,
                s.mytaglist,
                s.mypromptbox,
                tbox_separator,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                tbox_separator,
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
                tbox_separator_alt,
            },
        }
    }
end)
