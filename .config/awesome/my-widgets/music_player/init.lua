local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local common = require("my-widgets.common")

-- widgets
local albumArt = require("my-widgets.music_player.album_art")
local mediaInfo = require("my-widgets.music_player.media_info")

-- updateable widget vars
local titleWidget = mediaInfo:get_children_by_id("title")[1]
local artistWidget = mediaInfo:get_children_by_id("artist")[1]

local positionWidget = mediaInfo:get_children_by_id("currentPos")[1]
local lengthWidget = mediaInfo:get_children_by_id("totalLen")[1]

local artWidget = albumArt:get_children_by_id("myArt")[1]

-- widget data
local widgetInfo = {
    title = nil,
    artist = nil,
    position = nil,
    length = nil,
    art = nil
}

local updateInfo = function(widget, widgetType, info) -- used to distinguish b/w title and album icon
    local cases = {
        ["art"] = function()
            widget:set_image(gears.surface.load_uncached(info))
        end,
        ["artist"] = function()
            widget:set_text("󰠃 " .. info)
        end,
        ["title"] = function()
            widget:set_text("󰽱 " .. info)
        end,
        ["position"] = function()
            widget:set_text(info)
        end,
        ["length"] = function()
            widget:set_text(info)
        end
    }
    local update = cases[widgetType]
    update()
end

local getInfo = function()
    local playerctlStr =
        [[ playerctl -i "chromium" metadata --format "length_{{ duration(mpris:length)}}^title_{{ title }}^artist_{{ artist }}^art_{{ mpris:artUrl }}" -F]]

    -- some stolen func that un-escapes special characters
    local hex_to_char = function(x)
        return string.char(tonumber(x, 16))
    end

    local unescape = function(url)
        return url:gsub("%%(%x%x)", hex_to_char)
    end

    -- awful.spawn.easy_async_with_shell("pkill playerctl", function()
    local pid = awful.spawn.with_line_callback(playerctlStr, {
        stdout = function(line)
            -- metadata
            widgetInfo.title = line:match("title_(.-)^") or "Nothing's playing"
            widgetInfo.artist = line:match("artist_(.-)^") or "Nothing's playing"

            -- length
            widgetInfo.length = line:match("length_(.-)^") or "XX"

            if widgetInfo.title and widgetInfo.artist ~= "Nothing's playing" then
                widgetInfo.title = string.sub(widgetInfo.title, 1, 20)
                widgetInfo.artist = string.sub(widgetInfo.artist, 1, 20)
            end
            -- album art (cause some songs don't have album art)
            widgetInfo.art = line:match("art_file:%/%/(.-)$") or "No album art available"
            if widgetInfo.art ~= "No album art available" then
                widgetInfo.art = unescape(widgetInfo.art)
            else
                widgetInfo.art = beautiful.player_icons .. "music_player.png"
            end

            -- time to update
            updateInfo(titleWidget, "title", widgetInfo.title)
            updateInfo(artistWidget, "artist", widgetInfo.artist)
            updateInfo(lengthWidget, "length", widgetInfo.length)
            updateInfo(artWidget, "art", widgetInfo.art)

            collectgarbage()
        end,
        stderr = function(line)
            common.testNotif(line)
        end
    })
    -- awful.spawn.with_shell("killall playerctl")
    -- end)
end

-- separate function for position cause it needs to be updated every second
local getPosition = function()
    local playerctlStr = [[ playerctl -i "chromium" metadata --format "pos_{{ duration(position) }}" -F]]

    local pid = awful.spawn.with_line_callback(playerctlStr, {
        stdout = function(line)
            -- position and length`
            widgetInfo.position = line:match("pos_(.-)$") or "XX"

            -- time to update
            updateInfo(positionWidget, "position", widgetInfo.position)

        end,
        stderr = function(line)
            common.testNotif(line)
        end
    })
    -- awesome.register_xproperty("playerctlPid2", pid)
end

-- fetch info
getInfo()
getPosition()

-- kill playerctl processes after restart
awesome.connect_signal("exit", function(_, reason)
    awful.spawn.with_shell("killall playerctl")
end)

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
