local awful = require("awful")
local beautiful = require("beautiful")
local common = require("my-widgets.common")

-- music data
local musicInfo = {
    title = "",
    artist = "",
    position = "",
    length = "",
    art = ""
}

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
            musicInfo.title = line:match("title_(.-)^") or "Nothing's playing"
            musicInfo.artist = line:match("artist_(.-)^") or "Nothing's playing"

            -- length
            musicInfo.length = line:match("length_(.-)^") or "XX"

			-- trimming info
            if musicInfo.title and musicInfo.artist ~= "Nothing's playing" then
                musicInfo.title = string.sub(musicInfo.title, 1, 20)
                musicInfo.artist = string.sub(musicInfo.artist, 1, 20)
            end

            -- album art (cause some songs don't have album art)
            musicInfo.art = line:match("art_file:%/%/(.-)$") or "No album art available"
            if musicInfo.art ~= "No album art available" then
                musicInfo.art = unescape(musicInfo.art)
            else
                musicInfo.art = beautiful.player_icons .. "music_player.png"
            end

            collectgarbage()

			-- emit signal for updating values
			awesome.emit_signal("update_music_info")
        end,
        stderr = function(line)
            common.testNotif(line)
        end
    })
end

-- separate function for position cause it needs to be updated every second
local getPosition = function()
    local playerctlStr = [[ playerctl -i "chromium" metadata --format "pos_{{ duration(position) }}" -F]]

    local pid = awful.spawn.with_line_callback(playerctlStr, {
        stdout = function(line)
            musicInfo.position = line:match("pos_(.-)$") or "XX"

			-- emit signal for updating values
			awesome.emit_signal("update_position")
        end,
        stderr = function(line)
            common.testNotif(line)
        end
    })
end

-- fetch info
getInfo()
getPosition()

-- kill playerctl processes after restart
awesome.connect_signal("exit", function(_, reason)
    awful.spawn.with_shell("killall playerctl")
end)

return musicInfo
