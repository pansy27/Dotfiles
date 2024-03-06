local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local awful = require("awful")
local common = require("my-widgets.common")

-- widget
local controlButtons = wibox.widget {
    {
        {
            -- prev button
            {
                {
                    {
                        {
                            image = beautiful.player_icons .. "prev.svg",
                            forced_height = dpi(25),
                            forced_width = dpi(25),
                            widget = wibox.widget.imagebox
                        },
                        margins = dpi(10),
                        widget = wibox.container.margin
                    },
                    id = "control",
                    bg = beautiful.player_button,
                    shape = common.rrect(10),
                    widget = wibox.container.background
                },
                halign = "center",
                widget = wibox.container.place
            },

            -- pause-play button
            {
                {

                    {
                        {
                            image = beautiful.player_icons .. "play.svg",
                            forced_height = dpi(25),
                            forced_width = dpi(25),
                            widget = wibox.widget.imagebox
                        },
                        margins = dpi(10),
                        widget = wibox.container.margin
                    },
                    id = "control",
                    bg = beautiful.player_button,
                    shape = common.rrect(10),
                    widget = wibox.container.background
                },
                halign = "center",
                widget = wibox.container.place
            },

            -- next button
            {
                {
                    {
                        {
                            image = beautiful.player_icons .. "next.svg",
                            forced_height = dpi(25),
                            forced_width = dpi(25),
                            widget = wibox.widget.imagebox
                        },
                        margins = dpi(10),
                        widget = wibox.container.margin
                    },
                    id = "control",
                    bg = beautiful.player_button,
                    shape = common.rrect(10),
                    widget = wibox.container.background
                },
                halign = "center",
                widget = wibox.container.place
            },
            layout = wibox.layout.flex.vertical
        },
        forced_width = dpi(60),
        forced_height = dpi(250),
        bg = beautiful.colors.light_blue,
        shape = common.rrect(5),
        widget = wibox.container.background
    },
    halign = "right",
    widget = wibox.container.place
}

local albumArt = wibox.widget {
    {
        -- background image
        {
            {
                image = beautiful.player_icons .. "bg.jpg",
                -- resize = false,
                -- horizontal_fit_policy = 'repeat',
                forced_width = dpi(360),
                shape = common.rrect(3),
                opacity = 0.8,
                widget = wibox.widget.imagebox
            },
            widget = wibox.container.place
        },

        -- actual album art
        {
            {
                {
                    {
                        image = beautiful.player_icons .. "music_player.png",
                        resize = true,
                        valign = "center",
                        halign = "center",
                        -- scaling_quality = "fast",
                        id = "myArt",
                        clip_shape = common.rrect(3),
                        forced_height = dpi(260),
                        forced_width = dpi(280),
                        widget = wibox.widget.imagebox
                    },
                    -- for debug purposes
                -- bg = "orange",
                widget = wibox.container.background
            },
            halign = "left",
            widget = wibox.container.place
        },
        margins = dpi(20),
        widget = wibox.container.margin,
        },

        -- buttons
        {
            controlButtons,
            right = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.stack
    },
    top = dpi(10),
    widget = wibox.container.margin

}

-- adding buttons
local commands = {
    "playerctl -i \"chromium\" previous",
    "playerctl -i \"chromium\" play-pause",
    "playerctl -i \"chromium\" next",
}

local conButton = controlButtons:get_children_by_id("control")

for i = 1, #conButton do
        conButton[i].buttons = {
            awful.button({}, "1",function()
                awful.spawn.with_shell(commands[i])
            end)
        }
end

return albumArt
