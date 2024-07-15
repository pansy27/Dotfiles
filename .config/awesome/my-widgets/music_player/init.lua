local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

-- User modules
local common = require("my-widgets.common")
local musicInfo = require("my-widgets.music")

-- widgets
local albumArt = require("my-widgets.music_player.album_art")
local mediaInfo = require("my-widgets.music_player.media_info")

-- updateable widget vars
local titleWidget = mediaInfo:get_children_by_id("title")[1]
local artistWidget = mediaInfo:get_children_by_id("artist")[1]

local positionWidget = mediaInfo:get_children_by_id("currentPos")[1]
local lengthWidget = mediaInfo:get_children_by_id("totalLen")[1]

local artWidget = albumArt:get_children_by_id("myArt")[1]


-- Updating music widget
local updateInfo = function()
	titleWidget:set_text("󰎇  " .. musicInfo.title)
	artistWidget:set_text("󰠃  " .. musicInfo.artist)
	lengthWidget:set_text(musicInfo.length)
	artWidget:set_image(gears.surface.load_uncached(musicInfo.art))
end

local updateInfo2 = function()
	positionWidget:set_text(" " .. musicInfo.position)
end

collectgarbage()

-- Connecting to update signals
awesome.connect_signal("update_music_info", updateInfo)
awesome.connect_signal("update_position", updateInfo2)

-- Final widget
local player = wibox {
    visible = false,
    ontop = true,
    width = dpi(380),
    height = dpi(350),
    bg = "#00000000"
}

player:setup{
    {
        albumArt,
        nil,
        mediaInfo,
        id = "myRatio",
        layout = wibox.layout.ratio.vertical
    },
    bg = beautiful.player_bg,
    shape = common.rrect(5),
    widget = wibox.container.background
}

player:get_children_by_id("myRatio")[1]:adjust_ratio(1, 0, 0.75, 0.25)

-- toggle dashboard
local function player_visibility()
    if player.visible == true then
        player.visible = false
    else
        player.visible = true
    end
end

-- with mouse
player.buttons = {awful.button({}, 3, function()
    player_visibility()
end)}

-- keybind
awful.keyboard.append_global_keybindings({awful.key({"Mod4"}, "x", function()
    player_visibility()
end)})

-- Placing it on screen
awful.placement.align(player, {
    margins = {
        top = dpi(60),
        left = dpi(250)
    },
    position = "top",
    parent = awful.screen.focused()
})
