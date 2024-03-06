local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
      {    {
                image     = beautiful.wallpaper,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        },
      bg = "#343434",
      widget = wibox.widget.background,
    }
  }
end)
