local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local ruled = require("ruled")
local naughty = require("naughty")
local wibox = require("wibox")

local common = require("my-widgets.common")

-- Notifications
ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5
        }
    })
    ruled.notification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = beautiful.colors.silly_fg, fg = beautiful.colors.silly_bg, timeout = 0 }
    }
    ruled.notification.append_rule {
        rule       = { urgency = 'low' },
        properties = { bg = beautiful.colors.app_bg, fg = beautiful.colors.silly_fg }
    }
end)

naughty.connect_signal("request::display", function(n)
    -- weird fix for notif border
    naughty.config.defaults.border_width = beautiful.notification_border_width

    local notifButtons = wibox.widget {
        base_layout = wibox.widget {
            spacing = dpi(3),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            -- margin container
            {
                -- background container
                {
                    -- margin container
                    {
                        -- place container cause it automatically centers
                        {
                            id = "text_role",
                            font = beautiful.font_med .. "10",
                            widget = wibox.widget.textbox
                        },
                        margins = dpi(5),
                        widget = wibox.container.margin
                    },
                    widget = wibox.container.place
                },
                shape = common.rrect(5),
                bg = beautiful.colors.light_blue,
                fg = beautiful.colors.dark_blue,
                widget = wibox.container.background
            },
            margins = dpi(5),
            widget = wibox.container.margin
        },
        widget = naughty.list.actions
    }

    -- main layout
    naughty.layout.box {
        notification = n,
        position = beautiful.notification_position,
        shape = common.rrect(5),
        widget_template = {
            -- background container
            {
                -- contraint size
                {
                    {
                        {
                            -- notif text
                            {
                                naughty.widget.icon,
                                {
                                    naughty.widget.title,
                                    naughty.widget.message,
                                    spacing = dpi(5),
                                    layout = wibox.layout.fixed.vertical
                                },
                                fill_space = true,
                                spacing = dpi(10),
                                layout = wibox.layout.fixed.horizontal
                            },

                            -- notif actions
                            notifButtons,
                            spacing = dpi(5),
                            layout = wibox.layout.fixed.vertical
                        },
                        margins = dpi(10),
                        left = dpi(15),
                        right = dpi(15),
                        widget = wibox.container.margin
                    },
                    strategy = "min",
                    width = beautiful.notification_min_width or dpi(150),
                    widget = wibox.container.constraint
                },
                strategy = "max",
                width = beautiful.notification_max_width or dpi(400),
                widget = wibox.container.constraint
            },
            id = "background_role",
            widget = naughty.container.background
        }

    }
end)
