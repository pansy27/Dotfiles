local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local common = require("my-widgets.common")

local topPart = require("my-widgets.sidebar.top")
local centrePart = require("my-widgets.sidebar.centre")
local bottomPart = require("my-widgets.sidebar.bottom")

local sidebar = wibox {
   visible = false,
   bg = beautiful.colors.cinnamon_white,
   ontop = true,
   height = dpi(768),
   width = dpi(400),
   shape = common.rrect(3),
}

-- try making floating window close button

---- finalizing sidebar -----------
sidebar:setup {
   topPart,
   centrePart,
   bottomPart,
   layout = wibox.layout.align.vertical,
}
-- sidebar:adjust_ratio(2, 0.3, 0.4, 0.3)

collectgarbage()

-- toggle dashboard
local function sidebar_visibility()
   if sidebar.visible == true then
      sidebar.visible = false
   else
      sidebar.visible = true
   end
end

-- with mouse
sidebar.buttons = {
   awful.button({ }, 3, function ()
      sidebar_visibility()
     end),
}


-- keybind
awful.keyboard.append_global_keybindings({
      awful.key({ "Mod4" }, "b", function()
	    sidebar_visibility()
      end)
})
-- Placing it on screen
awful.placement.left(
   sidebar,
   {
      -- margins = {top = 0},
      parent = awful.screen.focused()})
