local awful = require("awful")
local ruled = require("ruled")

-- Rules for new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    })

    -- Floating clients.
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = {"copyq", "pinentry"},
            class = {"Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv", "Tor Browser", "Wpa_gui", "veromix",
                     "xtightvncviewer"},
            -- Note that the name property shown in xprop might be set slightly
            -- after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {"Event Tester" -- xev.
            },
            role = {"AlarmWindow", -- Thunderbird's calendar.
            "ConfigManager", -- Thunderbird's about:config.
            "pop-up" -- e.g. Google Chrome's (detached)
            -- Developer Tools.
            }
        },
        properties = {
            floating = true
        }
    })

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule({
        id = "titlebars",
        rule_any = {
            type = {"normal", "dialog"}
        },
        properties = {
            titlebars_enabled = false
        }
    })

    ruled.client.append_rule {
        rule = {
            class = "Vivaldi-stable"
        },
        properties = {
            maximized_vertical = true,
            titlebars_enabled = false
        }
    }
    ruled.client.append_rule({
        rule = {
            name = "Picture-in-Picture"
        },
        properties = {
            ontop = true
            -- titlebars_enabled = true
        }
    })
    ruled.client.append_rule({
        rule = {
            class = "mpv"
        },
        properties = {
            floating = true,
            -- titlebars_enabled = true
        }
    })
    ruled.client.append_rule({
        rule = {
            class = "xdman-Main"
        },
        properties = {
            floating = true
        }
    })

    ruled.client.append_rule({
        rule = {
            instance = "vscodium"
        },
        properties = {
            maximized_vertical = true,
            titlebars_enabled = false
            --[[ tag = "2" ]]
        }
    })

end)

-- make floating windows stay on top
--[[ client.connect_signal("property::floating", function(c)
    if not c.floating then
      c.ontop = true
    end
end) ]]
