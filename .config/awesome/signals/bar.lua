local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local common = require("my-widgets.common")

-- Clock widget
local myClock = wibox.widget({
	{
		wibox.widget.textclock(" %H:%M "),
		margins = dpi(4),
		widget = wibox.container.margin,
	},
	bg = beautiful.colors.blue,
	fg = beautiful.colors.dark_blue,
	shape = common.rrect(2),
	widget = wibox.container.background,
})

-- Volume change on scroll
myClock.buttons = {
  awful.button({}, 4, function ()
		awful.spawn("wpctl set-volume @DEFAULT_SINK@ 5%+")
  end), 
  awful.button({}, 5, function ()
		awful.spawn("wpctl set-volume @DEFAULT_SINK@ 5%-")
  end), 
}

-- Wibar

screen.connect_signal("request::desktop_decoration", function(s)
	-- Each screen has its own tag table.
	awful.tag({ "", "", "", "", "", "", "", "", "", "" }, s, awful.layout.layouts[1])

	s.myLayoutbox = awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(1)
			end),
		},
	})

	-- Create a taglist widget
	s.myTaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end),
		},
	})

	-- Create a tasklist widget
	s.myTasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		layout = {
			spacing = dpi(10),
			layout = wibox.layout.flex.horizontal,
		},
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({
					context = "tasklist",
					action = "toggle_minimization",
				})
			end),
			awful.button({}, 3, function()
				awful.menu.client_list({
					theme = {
						width = dpi(250),
						height = dpi(25),
					},
				})
			end),
			awful.button({}, 4, function()
				awful.client.focus.byidx(-1)
			end),
			awful.button({}, 5, function()
				awful.client.focus.byidx(1)
			end),
		},
		widget_template = {
			-- background container
			{
				-- margin container
				{
					-- place container
					{
						-- restrict size
						{
							-- actual stuff
							{
								-- id = "icon_role",
								widget = wibox.widget.imagebox,
							},
							{
								id = "text_role",
								widget = wibox.widget.textbox,
							},
							spacing = dpi(5),
							layout = wibox.layout.fixed.horizontal,
						},
						strategy = "max",
						width = dpi(200),
						widget = wibox.container.constraint,
					},
					valign = "center",
					halign = "center",
					widget = wibox.container.place,
				},
				left = dpi(10),
				right = dpi(10),
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create the wibox
	s.myWibar = awful.wibar({
		screen = s,
		width = dpi(1100),
		height = dpi(35),
		position = "bottom",
		widget = {
			{
				{
					mylauncher,
					s.myTaglist,
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal,
				},
				s.myTasklist,
				{
					wibox.widget.systray(),
					myClock,
					{
						s.myLayoutbox,
						margins = dpi(3),
						left = dpi(0),
						widget = wibox.container.margin,
					},
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal,
				},
				spacing = dpi(10),
				layout = wibox.layout.align.horizontal,
			},
			margins = {
				left = dpi(20),
				right = dpi(20),
				top = dpi(5),
				bottom = dpi(5),
			},
			widget = wibox.container.margin,
		},
	})
end)
