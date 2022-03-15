local gears = require("gears")
local beautiful = require("beautiful")
-- Wallpaper settings
-- Deprecated gears.wallpaper
 screen.connect_signal("request::wallpaper", function(s)
     -- Wallpaper
     if beautiful.wallpaper then
         local wallpaper = beautiful.wallpaper
         -- If wallpaper is a function, call it with the screen
         if type(wallpaper) == "function" then
             wallpaper = wallpaper(s)
         end
         gears.wallpaper.maximized(beautiful.wallpaper, s)
     end
end)
 
-- New awful.wallpaper(doesn't have maximized)
--   awful.wallpaper {
--       screen = s,
--       widget = {
--           {
--               image  = beautiful.wallpaper,
--               resize = true,
--               widget = wibox.widget.imagebox,
--           },
--           valign = "center",
--           halign = "center",
--           tiled  = false,
--           widget = wibox.container.tile,
--       }
--   }

