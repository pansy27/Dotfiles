local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local common = require("my-widgets.common")

-- controls
local mediaInfo = wibox.widget {
    -- margin container
    {
        -- background container
        {
            {
                -- song info
                {
                    {
                        text = '󰽱  Nothing Playing',
                        halign = 'left',
                        valign = 'top',
                        id = "title",
                        font = beautiful.font_med .. "12",
                        widget = wibox.widget.textbox
                    },
                    nil,
                    {
                        -- can't use markup cause special characters
                        text = '󰠃  Nothing Playing',
                        halign = 'left',
                        valign = 'bottom',
                        id = "artist",
                        font = beautiful.font_reg .. "11",
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.align.vertical
                },

                nil,

                -- song length and position info
                {
                    -- current position part
                    {
                        text = 'XX',
                        halign = 'right',
                        valign = 'center',
                        id = "currentPos",
                        font = beautiful.font_bold .. "20",
                        widget = wibox.widget.textbox
                    },

                    -- separator
                    {
                        text = "/",
                        halign = "right",
                        valign = "center",
                        font = beautiful.font_med .. "25",
                        widget = wibox.widget.textbox
                    },

                    -- full length part

                    {
                        text = 'XX',
                        halign = 'right',
                        valign = 'center',
                        id = "totalLen",
                        font = beautiful.font_bold .. "20",
                        widget = wibox.widget.textbox
                    },
                    id = "songLengthRatio",
                    spacing = dpi(5),
                    layout = wibox.layout.fixed.horizontal
                },
                id = "mediaInfoRatio",
                -- spacing = dpi(10),
                layout = wibox.layout.align.horizontal
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        fg = beautiful.colors.silly_fg,
        bg = beautiful.colors.light_blue,
        shape = common.rrect(3),
        widget = wibox.container.background
    },
    margins = dpi(10),
    shape = common.rrect(30),
    widget = wibox.container.margin
}

return mediaInfo
