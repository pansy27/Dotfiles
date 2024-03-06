local awful = require("awful")

-- mouse bindings for clients
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ "Mod1" }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),
		awful.button({ "Mod1" }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)
