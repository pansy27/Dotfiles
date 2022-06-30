pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
local ruled = require("ruled")
local gears = require("gears")
-- Importing rest of the Modules
require "modules/error"
require "modules/base"
require "modules/layouts"
require "modules/wibar"
--require "modules/tags"
require "modules/keybinds"
--require "modules/slidebar"
require "modules/notifs"
require "modules/menu"
require "modules/titlebar"
require "modules/wallpaper"
--  Rules
-- Rules for new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }
    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true      }
    }
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
    ruled.client.append_rule {
        rule         = { name = "Picture-in-Picture" },
        properties   = { ontop = true }
    }
    ruled.client.append_rule {
        rule         = { class = "mpv" },
        properties   = { floating = true }
    }
    ruled.client.append_rule {
        rule         = { class="xdman-Main" },
        properties   = { floating = true }
    }
    ruled.client.append_rule {
        rule         = { instance = "Navigator" },
        properties   = { maximized_vertical = true }
    }
end)

-- Sloppy focus
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)


--[[ nice module
local nice = require("nice")
nice()
]]--
-- Autostart script
awful.spawn.with_shell("$HOME/.config/awesome/autostart.sh")
-- Run garbage collector regularly to prevent memory leaks
gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
}

