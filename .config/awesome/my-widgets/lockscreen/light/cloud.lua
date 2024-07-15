-- local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

-- User imports
local common = require("my-widgets.common")
local musicInfo = require("my-widgets.music")

local passwordWidget = {}

passwordWidget.promptBox = wibox.widget {
	{
		{
			{
				{
					id = "passwd_indicator",
					markup = "♡",
					font = "Roboto 25",
					widget = wibox.widget.textbox
				},
				-- bg = "orange",
				fg = beautiful.colors.slate_grey,
				widget = wibox.container.background
			},
			{
				{
					{
						id = "passwd_box",
						markup = " ",
						font = "Roboto Bold 18",
						forced_width = dpi(130),
						forced_height = dpi(25),
						widget = wibox.widget.textbox
					},
					margins = {
						left = dpi(10),
						right = dpi(10),
						top = dpi(6),
						bottom = dpi(4)
					},
					layout = wibox.container.margin
				},
				bg = beautiful.colors.silly_bg .. "F5" ,
				fg = beautiful.colors.silly_fg,
				shape = common.rrect(5),
				-- opacity = 0.4,
				widget = wibox.container.background
			},
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal
		},
		valign = "top",
		layout = wibox.container.place
	},
	top = dpi(55),
	left = dpi(-30),
	layout = wibox.container.margin
}

passwordWidget.greeting = wibox.widget {
	{
		{
			{
				-- greeting icon
				{
					{
						image =  beautiful.lockscreen_greeter_icon,
						forced_width = dpi(80),
						forced_height = dpi(80),
						widget = wibox.widget.imagebox
					},
					-- bg = "orange",
					-- opacity = 0.9,
					shape = common.rrect(6),
					widget = wibox.container.background
				},

				-- greeting text
				{
					{
						{
							markup = "<b>eepy time</b>",
							font = "Comic Sans MS 33",
							forced_width = dpi(230),
							forced_height = dpi(40),
							halign = "center",
							widget = wibox.widget.textbox
						},
						-- bg = "orange",
						fg = beautiful.colors.slate_grey,
						-- opacity = 0.6,
						shape = common.rrect(4),
						widget = wibox.container.background
					},
					-- top = dpi(0),
					layout = wibox.container.margin
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.horizontal
			},
			halign = "left",
			layout = wibox.container.place
		},
		left = dpi(60),
		top = dpi(10),
		layout = wibox.container.margin
	},
	-- bg = "#d1beef",
	widget = wibox.container.background
}

local cloudBg = wibox.widget {
	{
		{
			{
				{
					image = beautiful.lockscreen_popup,
					forced_height = dpi(300),
					forced_width = dpi(450),
					widget = wibox.widget.imagebox
				},
				passwordWidget.promptBox,
				passwordWidget.greeting,
				layout = wibox.layout.stack
			},
			-- bg = "#d1beef",
			widget = wibox.container.background
		},
		-- height = "100px",
		-- width = "100px",
		valign = "top",
		halign = "left",
		layout = wibox.container.place
	},
	-- bg = "orange",
	-- opacity = 0.4,
	widget = wibox.container.background
}

-- final cloud widget
passwordWidget.cloudWidget = wibox.widget {
	cloudBg,
	left = dpi(680),
	top = dpi(80),
	layout = wibox.container.margin
}

return passwordWidget
