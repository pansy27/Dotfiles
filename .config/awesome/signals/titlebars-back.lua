local awful = require("awful")
local wibox = require("wibox")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = {
		awful.button({}, 1, function()
			c:activate({ context = "titlebar", action = "mouse_move" })
		end),
		awful.button({}, 3, function()
			c:activate({ context = "titlebar", action = "mouse_resize" })
		end),
	}
	local myMinimize = wibox.widget {
	   {
	      {
		widget =  awful.titlebar.widget.button(
		    c,
		    "minimize",
		    function()
		       return true
		    end,
		    function(c)
		       c.minimized = true
		       end
		     )
	      },
	     margins = 5,
	     widget = wibox.container.margin
	   },
	   bg = "#D7BBF5",
	   widget = wibox.container.background, 
	}	
	awful.titlebar(c).widget = {
		--[[ { -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		}, ]]
    nil,
		{ -- Middle
			{ -- Title
				halign = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			-- awful.titlebar.widget.floatingbutton(c),
			myMinimize,
			{
			   {
			      {
				 widget = awful.titlebar.widget.maximizedbutton(c)
			      },
			      margins = 4,
			      widget = wibox.container.margin
			   },
			   bg = "#C9EEFF",
			   widget = wibox.container.background
			},
--			awful.titlebar.widget.maximizedbutton(c),
			-- awful.titlebar.widget.stickybutton(c),
			-- awful.titlebar.widget.ontopbutton(c),
			{
			   {
			      {
				 widget = awful.titlebar.widget.closebutton(c)
			      },
			      margins = 4,
			      widget = wibox.container.margin
			   },
			   bg = "#F7A5AC",
			   widget = wibox.container.background
			},
			
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	}
end)
