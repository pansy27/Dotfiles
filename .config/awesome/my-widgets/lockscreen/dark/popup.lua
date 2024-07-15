local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")

-- User modules
local common = require("my-widgets.common")


local passwordWidget = {}

local clock = wibox.widget {
	{
		{
			-- hour
			{
				{
					format = "%H",
					font = "Google Sans 55",
					widget = wibox.widget.textclock
				},
				fg = "#c37aa0",
				widget = wibox.container.background
			},
			-- separator
			{
				{
					format = " : ",
					font = "Google Sans 55",
					widget = wibox.widget.textclock
				},
				fg = beautiful.colors.slate_grey,
				widget = wibox.container.background
			},
			-- minute
			{
				{
					format = "%M",
					font = "Google Sans 55",
					widget = wibox.widget.textclock
				},
				fg = "#99c5c6",
				widget = wibox.container.background
			},
			layout = wibox.layout.fixed.horizontal
		},
		valign = "top",
		layout = wibox.container.place
	},
	-- bg = "#f8928a",
	margins = dpi(30),
	widget = wibox.container.margin
	-- layout = wibox.container.margin
}

passwordWidget.passwdPrompt = wibox.widget {
	{
		{
			-- lock icon
			{
				{
					id = "passwd_indicator",
					image = beautiful.lockscreen_lock,
					forced_height = dpi(60),
					forced_width = dpi(60),
					widget = wibox.widget.imagebox
				},
				-- bg = "orange",
				widget = wibox.container.background
			},

			-- prompt
			{
				{
					{
						id = "passwd_box",
						markup = "",
						font = "Google Sans 30",
						forced_width = dpi(150),
						forced_height = dpi(50),
						halign = "left",
						valign = "center",
						widget = wibox.widget.textbox
					},
					margins = {
						left = dpi(20),
						right = dpi(10),
						top = dpi(10),
						-- bottom = dpi(5)
					},
					layout = wibox.container.margin
				},
				bg = "#2f2624",
				fg = beautiful.colors.cinnamon_white,
				shape = common.rrect(4),
				widget = wibox.container.background
			},
			spacing = dpi(20),
			layout = wibox.layout.fixed.horizontal
		},
		layout = wibox.container.place
	},
	layout = wibox.container.margin
}

local greeting = wibox.widget {
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
							markup = "<b>eeep now ⛈️</b>",
							font = "Comic Sans MS 20",
							forced_width = dpi(230),
							forced_height = dpi(40),
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
				spacing = dpi(20),
				layout = wibox.layout.fixed.horizontal
			},
			halign = "left",
			valign = "bottom",
			layout = wibox.container.place
		},
		left = dpi(60),
		bottom = dpi(30),
		layout = wibox.container.margin
	},
	-- bg = "#d1beef",
	widget = wibox.container.background
}

local passwordBoxBg = wibox.widget {
	{
		{
			{
				-- bg
				{
					{
						bg = beautiful.colors.cinnamon_white,
						forced_height = dpi(350),
						forced_width = dpi(350),
						shape = common.rrect(8),
						widget = wibox.container.background
					},
					{
						{
							image = beautiful.lockscreen_bg_alt,
						forced_height = dpi(350),
						forced_width = dpi(350),
							widget  = wibox.widget.imagebox
						},
						-- bg = "orange",
						opacity = 0.3,
						widget = wibox.container.background
					},
					layout = wibox.layout.stack
				},
				clock,
				passwordWidget.passwdPrompt,
				greeting,
				layout = wibox.layout.stack
			},
			halign = "right",
			layout = wibox.container.place
		},
		margins = dpi(50),
		top = dpi(120),
		layout = wibox.container.margin
	},
	-- bg = "orange",
	-- opacity = 0.4,
	widget = wibox.container.background
}
-- main window
passwordWidget.passwordBox = wibox.widget {
	passwordBoxBg,
	layout = wibox.container.margin
}


return passwordWidget
