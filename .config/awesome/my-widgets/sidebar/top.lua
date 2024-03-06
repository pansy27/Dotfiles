local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local common = require("my-widgets.common")

local userPic = {
    {
        {
            {
                image = beautiful.sidebar_icons .. "pfp.png",
                forced_width = dpi(100),
                forced_height = dpi(100),
                resize = true,
                widget = wibox.widget.imagebox
            },
            shape = common.rrect(100),
            bg = beautiful.fg_2,
            widget = wibox.container.background
        },
        -- changes pfp border width
        margins = dpi(3),
        widget = wibox.container.margin
    },
    bg = beautiful.blue_2,
    shape = common.rrect(100),
    widget = wibox.container.background
}

local greet = wibox.widget {
    {
        -- big greeting
        {
            {
                {
                    {
                        text = "hewwwo :3",
                        font = beautiful.font_bold .. "25",
                        widget = wibox.widget.textbox
                    },
                    top = dpi(50),
                    widget = wibox.container.margin
                },
                -- bg = "red",
                id = "sendBooba",
                widget = wibox.container.background
            },
            widget = wibox.container.place
        },

        -- combining smol greeting and quote in an align layout
        {
            {
                {
                    -- smol greeting
                    {
                        {
                            halign = "right",
                            markup = "<i>eep <b>Pansy</b></i>",
                            font = beautiful.font_reg .. "13",
                            widget = wibox.widget.textbox
                        },
                        right = dpi(10),
                        top = dpi(-30),
                        widget = wibox.container.margin
                    },

                    {
                        {
                            markup = [[Roses are red, violets are blue
guess who's the mongrel?
Yes, it's <i>you</i>
                                     <b>Gilgamesh</b>]],
                            font = beautiful.font_reg .. "11",
                            valign = "top",
                            halign = "left",
                            widget = wibox.widget.textbox
                        },
                        top = dpi(10),
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.align.vertical
                },
                -- bg = "orange",
                widget = wibox.container.background
            },
            halign = "left",
            widget = wibox.container.place
        },
        layout = wibox.layout.align.vertical
    },
    fg = beautiful.fg_3,
    -- bg = "olive",
    forced_height = 200,
    widget = wibox.container.background
}

local deco = wibox.widget {
    -- first arrow(left)
    {
        {
            {
                {
                    text = "",
                    font = beautiful.font_nerd .. "8",
                    widget = wibox.widget.textbox
                },
                fg = beautiful.fg_1 .. "66",
                widget = wibox.container.background
            },
            top = dpi(3),
            right = dpi(20),
            widget = wibox.container.margin
        },
        valign = "top",
        halign = "left",
        layout = wibox.container.place

    },
    -- second arrow(right)
    {
        {
            {
                {
                    text = "",
                    font = beautiful.font_nerd .. "8",
                    widget = wibox.widget.textbox
                },
                fg = beautiful.fg_1 .. "66",
                widget = wibox.container.background
            },
            top = dpi(8),
            right = dpi(15),
            widget = wibox.container.margin
        },
        valign = "top",
        halign = "right",
        layout = wibox.container.place

    },
    -- comma
    {

        {
            {
                forced_height = dpi(20),
                forced_width = dpi(20),
                image = beautiful.sidebar_icons .. "comma.png",
                widget = wibox.widget.imagebox
            },
            top = dpi(15),
            left = dpi(-60),
            widget = wibox.container.margin
        },
        valign = "center",
        halign = "center",
        layout = wibox.container.place

    },
    layout = wibox.layout.stack
}

local top = wibox.widget {
    -- profile pic
    {
        {

            userPic,
            valign = "top",
            widget = wibox.container.place
        },
        top = dpi(30),
        left = dpi(20),
        widget = wibox.container.margin
    },
    -- greet message
    {
        {
            greet,
            layout = wibox.layout.flex.horizontal
        },
        left = dpi(20),
        widget = wibox.container.margin
    },
    layout = wibox.layout.align.horizontal
}

local topPart = wibox.widget {
    {
        -- background image
        {
            {
                image = beautiful.sidebar_icons .. "topBg.jpg",
                resize = true,
                opacity = 0.18,
                widget = wibox.widget.imagebox
            },
            -- bg = "yellow",
            shape = common.rrect(10),
            widget = wibox.container.background
        },
        ------------ Decoration widgets ---------------
        -- blud i'm not touching this file again ;-;
        top,
        deco,
        -- { -- only here for debug purposes
        --     -- bg = "#ff000040",
        --     widget = wibox.container.background
        -- },
        layout = wibox.layout.stack
    },
    -- margin on overall container  
    margins = dpi(15),
    top = dpi(5),
    bottom = dpi(0),
    forced_height = dpi(260),
    widget = wibox.container.margin
}

greet:get_children_by_id("sendBooba")[1].buttons = {awful.button({}, 1, function()
    naughty.notification({
        title = "You've run out of \"It is what it is\"",
        message = "hue?????\nWallahi, i'm  finished",
        icon = beautiful.sidebar_icons .. "shock.png",
        timeout = 30,
        
        actions = {naughty.action {
            name = "Joever 😭"
        }, naughty.action {
            name = "Never Lose Jope"
        }}
    })
end)}
return topPart
