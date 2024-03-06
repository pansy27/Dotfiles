local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local common = require("my-widgets.common")

-- hide the calendar header
local function decorate_cell(widget, flag)
    local ret = wibox.widget {
        widget = widget
    }
    if flag == "header" then
        ret.visible = false
    end
    return ret
end

-- calendar
local cal = wibox.widget {
    {
        {
            {
                spacing = dpi(5),
                start_sunday = true,
                date = os.date("*t"),
                fn_embed = decorate_cell,
                font = beautiful.font_reg .. "10",
                widget = wibox.widget.calendar.month
            },
            forced_height = dpi(150),
            forced_width = dpi(200),
            fg = beautiful.fg_1,
            widget = wibox.container.background
        },
        valign = "bottom",
        widget = wibox.container.place
    },
    {
        nil,
        -- current day
        {
            {
                {
                    format = "%d",
                    valign = "top",
                    halign = "right",
                    font = beautiful.font_bold .. "30",
                    widget = wibox.widget.textclock
                },
                fg = beautiful.fg_1,
                widget = wibox.container.background
            },
            valign = "top",
            halign = "right",
            widget = wibox.container.place
        },
        -- current month
        {
            {
                {
                    {
                        format = "%b",
                        valign = "center",
                        halign = "center",
                        font = beautiful.font_bold .. "20",
                        widget = wibox.widget.textclock
                    },
                    fg = beautiful.fg_1,
                    widget = wibox.container.background
                },
                margins = dpi(5),
                top = dpi(13),
                widget = wibox.container.margin
            },
            valign = "top",
            widget = wibox.container.place
        },
        id = "calDateRatio",
        layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.stack
}

local clock = wibox.widget {
    -- hour part
    {
        {
            {
                {
                    format = "%H",
                    font = beautiful.font_bold .. "35",
                    widget = wibox.widget.textclock
                },
                -- bg = "lime",
                fg = beautiful.fg_1,
                widget = wibox.container.background
            },
            valign = "center",
            halign = "right",
            widget = wibox.container.place
        },
        -- separator
        {
            {
                {
                    {
                        markup = ":",
                        font = beautiful.font_bold .. "25",
                        widget = wibox.widget.textbox
                    },
                    fg = beautiful.fg_1,
                    widget = wibox.container.background
                },
                top = 10,
                widget = wibox.container.margin
            },
            valign = "right",
            widget = wibox.container.place
        },
        -- minutes part
        {
            {
                {
                    {
                        format = "%M",
                        font = beautiful.font_bold .. "35",
                        widget = wibox.widget.textclock
                    },
                    fg = beautiful.fg_1,
                    widget = wibox.container.background
                },
                valign = "center",
                halign = "left",
                widget = wibox.container.place
            },
            -- another margin container to shift it downwards
            top = dpi(40),
            widget = wibox.container.margin
        },
        id = "clockRatio",
        layout = wibox.layout.ratio.horizontal
    },

    -- milk sticker :3
    {
        {
            {
                image = beautiful.sidebar_icons .. "milk.png",
                widget = wibox.widget.imagebox
            },
			id = "milk",
            forced_height = dpi(80),
            widget = wibox.container.background
        },
        valign = "top",
        widget = wibox.container.place
    },
    layout = wibox.layout.stack
}
clock:get_children_by_id("clockRatio")[1]:adjust_ratio(2, 0.45, 0.1, 0.45)

-- this wibox is needed cause i'm using ratio layout
local combo = wibox.widget {
    {
        cal,
        clock,
        id = "comboRatio",
        spacing = dpi(4),
        layout = wibox.layout.ratio.horizontal
    },
    margins = dpi(15),
    widget = wibox.container.margin
}
combo:get_children_by_id("comboRatio")[1]:adjust_ratio(1, 0, 0.55, 0.45)

local wall = wibox.widget {
    {
        image = beautiful.sidebar_icons .. "bottomBg.jpg",
        opacity = 0.8,
        resize = true,
        widget = wibox.widget.imagebox
    },
    shape = common.rrect(5),
    widget = wibox.container.background
}

local bottomPart = wibox.widget {
    {
        {
            wall,
            combo,
            layout = wibox.layout.stack
        },
        margins = dpi(15),
        top = dpi(20),
        widget = wibox.container.margin
    },
    --    bg = "olive", -- leaving it here for fixing probs later
    widget = wibox.container.background
}

clock:get_children_by_id("milk")[1].buttons =  {
	awful.button({}, 1, function()
		awful.spawn.with_shell("theme.sh")
	end)
}
return bottomPart
