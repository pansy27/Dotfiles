local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

local common = require("my-widgets.common")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

    local titlebarButtons = {awful.button({}, 1, function()
        c:activate({
            context = "titlebar",
            action = "mouse_move"
        })
    end), awful.button({}, 3, function()
        c:activate({
            context = "titlebar",
            action = "mouse_resize"
        })
    end)}

    local minimizeButton = wibox.widget {
        widget = awful.titlebar.widget.button(c, "minimize", function()
            return true
        end, function(c)
            c.minimized = true
        end)
    }

    local myTitlebar = awful.titlebar(c, {
        size = dpi(33)
    })

    myTitlebar.widget = {
        nil,
        {
            nil,
            buttons = titlebarButtons,
            widget = wibox.layout.flex.horizontal
        },
        -- Right
        {
            {
                {
                    {
                        {
                            widget = minimizeButton
                        },
                        margins = dpi(2),
                        widget = wibox.container.margin
                    },
                    shape = common.rrect(3),
                    bg = beautiful.colors.cinnamon_white,
                    widget = wibox.container.background
                },
                {
                    {
                        {
                            widget = awful.titlebar.widget.closebutton(c)
                        },
                        margins = dpi(2),
                        widget = wibox.container.margin
                    },
                    shape = common.rrect(3),
                    bg = beautiful.colors.cinnamon_white,
                    widget = wibox.container.background
                },
                spacing = dpi(7),
                layout = wibox.layout.flex.horizontal()
            },
            margins = dpi(7),
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.horizontal
    }
end)
