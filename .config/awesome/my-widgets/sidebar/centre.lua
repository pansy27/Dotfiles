local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local common = require("my-widgets.common")

-- extra backslash here as shell treats `#` as comment
local copyHex = function(hex)
    awful.spawn.with_shell("echo -n \\" .. hex .. " | xclip -selection clipboard")
    -- common.testNotif(hex)
end

local myTasks = awful.widget.tasklist {
    screen = screen[1],
    filter = awful.widget.tasklist.filter.currenttags,
    layout = {
        spacing = dpi(8),
        forced_num_rows = dpi(3),
        layout = wibox.layout.grid.horizontal
    },
    buttons = {awful.button({}, 1, function(c)
        c:activate{
            context = "tasklist",
            action = "toggle_minimization"
        }
    end)},

    widget_template = {
        {
            id = "clienticon",
            widget = awful.widget.clienticon
        },
        opacity = 1,
        forced_width = dpi(45),
        forced_height = dpi(45),
        shape = common.rrect(5),
        widget = wibox.container.background,

        -- changes opacity if client is minimized
        update_callback = function(self, c, index, clients)
            self.opacity = (c.minimized and 0.3) or 1
        end
    },

    create_callback = function(self, c, index, clients) -- luacheck: no unused
        self:get_children_by_id("clienticon")[1].client = c
    end

}

local clientListDeco = wibox.widget {
    {
        {
            text = "Windows: ",
            font = beautiful.font_med .. "15",
            widget = wibox.widget.textbox
        },
        id = "toggleWibar",
        fg = beautiful.fg_3,
        widget = wibox.container.background
    },
    {

        {
            {
                text = "Goober mode: ",
                font = beautiful.font_med .. "15",
                widget = wibox.widget.textbox
            },
            fg = beautiful.fg_3,
            widget = wibox.container.background
        },
        {
            {
                {
                    text = ":3c",
                    halign = "center",
                    font = beautiful.font_med .. "15",
                    widget = wibox.widget.textbox
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            id = "nightMode",
            fg = beautiful.fg_3,
            bg = beautiful.colors.purple,
            shape = common.rrect(5),
            widget = wibox.container.background
        },
        layout = wibox.layout.align.horizontal
    },
    id = "sillyRatio",
    layout = wibox.layout.ratio.horizontal
}

local clientList = wibox.widget {
    clientListDeco,
    {
        {
            {
                myTasks,
                left = dpi(10),
                top = dpi(10),
                widget = wibox.container.margin
            },
            bg = beautiful.colors.app_bg,
            shape = common.rrect(4),
            forced_height = dpi(200),
            forced_width = dpi(350),
            widget = wibox.container.background
        },
        top = dpi(5),
        bottom = dpi(10),
        -- forced_height = dpi(200),
        -- forced_width = dpi(350),
        widget = wibox.container.margin
    },
    layout = wibox.layout.align.vertical
}
clientListDeco:get_children_by_id("sillyRatio")[1]:adjust_ratio(1, 0, 0.4, 0.6)

-- color table
local colors = {"#ecdae3", "#6a7895", "#dfe7f2", "#bcc9e4", "#d1beef"}

-- widget table
local colorWidTab = {
    spacing = 10,
    layout = wibox.layout.flex.horizontal
}

-- looping
for i, color in ipairs(colors) do
    -- define widget
    local colorWidget = wibox.widget {
        {
            widget = wibox.container.place
        },
        id = "colorButton",
        forced_width = dpi(10),
        bg = colors[i],
        shape = common.rrect(),
        buttons = {awful.button({}, 1, function()
            copyHex(colors[i])
        end)},
        widget = wibox.container.background
    }
    -- add widget to widget table
    table.insert(colorWidTab, colorWidget)
end

local colorPalette = wibox.widget {
    colorWidTab,
    layout = wibox.layout.flex.horizontal
}

local comboBox = wibox.widget {
    {
        {
            {
                markup = "<b>Todo:</b> being silly &lt;3",
                font = beautiful.font_med .. "13",
                widget = wibox.widget.textbox
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        fg = beautiful.colors.silly_fg,
        bg = beautiful.colors.silly_bg,
        shape = common.rrect(4),
        widget = wibox.container.background
    },
    {
        {
            {
                {
                    {
                        colorPalette,
                        margins = dpi(10),
                        widget = wibox.container.margin
                    },
                    shape = common.rrect(4),
                    bg = beautiful.colors.cinnamon_white,
                    widget = wibox.container.background
                },
                margins = dpi(2.5),
                widget = wibox.container.margin
            },
            bg = beautiful.colors.dark_purple,
            shape = common.rrect(5),
            widget = wibox.container.background
        },
        left = dpi(5),
        widget = wibox.container.margin
    },
    layout = wibox.layout.align.horizontal
}

local sliderImg = wibox.widget {
    -- star
    {
        {
            {
                {
                    image = beautiful.sidebar_icons .. "star.svg",
                    forced_width = dpi(27),
                    opacity = 0.7,
                    widget = wibox.widget.imagebox
                },
                --  bg = "red",
                widget = wibox.container.background
            },
            top = dpi(9),
            left = dpi(1),
            widget = wibox.container.margin
        },
        valign = "top",
        widget = wibox.container.place
    },
    nil,
    -- moon(me :3)
    {
        {
            {
                {
                    image = beautiful.sidebar_icons .. "moon.svg",
                    forced_width = dpi(27),
                    opacity = 0.7,
                    widget = wibox.widget.imagebox
                },
                --  bg = "orange",
                widget = wibox.container.background
            },
            top = dpi(10),
            left = dpi(2),
            widget = wibox.container.margin
        },
        valign = "top",
        widget = wibox.container.place
    },
    expand = none,
    layout = wibox.layout.align.vertical
}

local brightSlider = wibox.widget {
    {
        {
            {
                {
                    {
                        {
                            {
                                -- trough settings
                                bar_active_color = beautiful.colors.slider.active,
                                bar_color = beautiful.colors.slider.inactive,
                                bar_height = dpi(5),
                                bar_shape = common.rrect(2),
                                -- handle stuff
                                handle_border_color = beautiful.colors.cinnamon_white,
                                handle_color = beautiful.colors.slider.dot,
                                handle_width = dpi(15),
                                handle_border_width = dpi(4),
                                handle_shape = gears.shape.circle, -- common.rrect isn't working

                                -- other stuff
                                value = 75,

                                maximum = 100,
                                minimum = 10,
                                forced_width = dpi(160),
                                id = "brightSlider",
                                widget = wibox.widget.slider
                            },
                            forced_height = dpi(35),
                            widget = wibox.container.margin
                        },
                        -- somehow fixes the growing problem
                        widget = wibox.container.place
                    },
                    -- main bg
                    bg = beautiful.fg_2,
                    shape = common.rrect(2),
                    widget = wibox.container.background
                },
                -- border width
                margins = dpi(3),
                widget = wibox.container.margin
            },
            -- border bg
            bg = beautiful.colors.slider.border,
            shape = common.rrect(4),
            widget = wibox.container.background
        },
        direction = "east",
        widget = wibox.container.rotate
    },
    sliderImg,
    layout = wibox.layout.stack
}

local centerPart = wibox.widget {
    {
        nil,
        {
            nil,
            clientList,
            comboBox,
            layout = wibox.layout.align.vertical
        },
        {
            brightSlider,
            left = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.align.horizontal
    },
    top = dpi(3),
    left = dpi(15),
    right = dpi(15),
    widget = wibox.container.margin
}

-- making brightness slider useful
local slider = brightSlider:get_children_by_id("brightSlider")[1]
slider:connect_signal("property::value", function(obj, value)
    awful.spawn.with_shell("xbacklight -set " .. value)
end)

-- night mode button
clientListDeco:get_children_by_id("nightMode")[1].buttons = {awful.button({}, 1, function()
    awful.spawn.with_shell("pkill -USR1 redshift-gtk")
end)}

-- toggle Wibar
clientListDeco:get_children_by_id("toggleWibar")[1].buttons = {
    awful.button({}, 1, function()
            myscreen = awful.screen.focused()
            myscreen.myWibar.visible = not myscreen.myWibar.visible
    end)
}
return centerPart

