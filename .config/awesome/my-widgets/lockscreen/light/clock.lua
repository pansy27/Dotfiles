local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

-- User modules
local common = require("my-widgets.common")

local clockBg = wibox.widget {
	{
		{
			{
				image = beautiful.lockscreen_frame,
				forced_height = dpi(200),
				forced_width = dpi(200),
				widget = wibox.widget.imagebox
			},
			-- bg = "#d1beef",
			widget = wibox.container.background
		},
		valign = "top",
		halign = "left",
		layout = wibox.container.place
	},
	-- bg = "orange",
	-- opacity = 0.4,
	widget = wibox.container.background
}

local clock = wibox.widget {
	{
		{
			{
				{
					format = "%H\n%M",
					font = "K Gothic 55",
					widget = wibox.widget.textclock
				},
				-- bg = "#d1beef",
				-- fg = "orange",
				fg = beautiful.colors.blue,
				widget = wibox.container.background
			},
			valign = "top",
			halign = "left",
			layout = wibox.container.place
		},
		left = dpi(15),
		top = dpi(43),
		layout = wibox.container.margin
	},
	-- bg = "orange",
	-- opacity = 0.4,
	widget = wibox.container.background
}

local clockWidget = wibox.widget {
	{
		clockBg,
		clock,
		layout = wibox.layout.stack
	},
	left = dpi(250),
	top = dpi(30),
	layout = wibox.container.margin
}



return clockWidget
