local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Define Mod key for keybinds
modkey = "Mod4"

-- Common keybinds
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey, }, "w",      function (c) c:kill()                         end,
                {description = "close", group = "client"}),
        awful.key({ modkey, }, "s",  awful.client.floating.toggle                     ,
                {description = "toggle floating", group = "client"}),
--        awful.key({ modkey, "Shift" }, "s",  awful.client.sticky.toggle                     ,
--                {description = "toggle sticky", group = "client"}),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
                {description = "move to master", group = "client"}),
        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "move to screen", group = "client"}),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "toggle keep on top", group = "client"}),
        awful.key({ modkey,           }, "x",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "minimize", group = "client"}),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "(un)maximize", group = "client"}),
    })
end)

-- {{{ My Keybinds
awful.keyboard.append_global_keybindings({

-- volume keybinds
    awful.key({}, "F3", function () awful.spawn("pamixer -i 5 --allow-boost") end),
    awful.key({}, "F2", function () awful.spawn("pamixer -d 5 --allow-boost") end),
    awful.key({}, "F4", function () awful.spawn("pamixer -t") end),
--rofi keybinds
    awful.key({ modkey, }, "d", function () awful.spawn("rofi -show drun") end),
    awful.key({ "Mod1", }, "n", function () awful.spawn("rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'") end),
    awful.key({ modkey, }, "n", function () awful.spawn("rofi -show notes -modi notes:~/.scripts/rofi/notes.py") end),
-- others
    awful.key({ modkey, }, "a", function () awful.spawn("emacsclient -c") end),
    awful.key({ "Mod1", }, "e", function () awful.spawn("nemo") end),
    awful.key({ modkey, }, "space", function () awful.spawn("env MOZ_DISABLE_RDD_SANDBOX=1 firefox") end),
    awful.key({ modkey, "Shift" }, "space", function () awful.spawn("firefox --private-window") end),
    awful.key({ modkey, }, "v", function () awful.spawn.with_shell("~/.scripts/lock-x.sh") end),
    awful.key({ "Control", "Shift"}, "Escape", function () awful.spawn.with_shell("alacritty -e btm") end),
    awful.key({ "Mod1", "Control"}, "Delete", function () awful.spawn("xkill") end),
    awful.key({ modkey, }, "g", function () awful.spawn("gtk3-widget-factory") end),
-- playerclt and mpc
    awful.key({ "Mod1", }, "a", function () awful.spawn("playerctl play-pause") end),
    awful.key({}, "F7", function () awful.spawn("mpc toggle") end),
-- light
    awful.key({}, "F9", function () awful.spawn("light -A 2") end),
    awful.key({}, "F6", function () awful.spawn("light -U 2") end),
-- Screenshot keybinds
--    awful.key({}, "Scroll_Lock", function() awful.spawn.with_shell("uguush -s -o fiery -F \"https://zz.ht\" -a 5379 -t \"bdUVgjTkZMJXk2K1YyIdZU4v2TDKu7EPLX41lcdKhzRdtmexEOQtOwHkwCUFyKuj\" -n") end),
    awful.key({}, "Scroll_Lock", function() awful.spawn.with_shell("shotgun -g $(slop) - | xclip -t 'image/png' -selection clipboard") end),
    awful.key({ "Shift" }, "Scroll_Lock", function() awful.spawn.with_shell("shotgun -g $(slop) - | swappy -f -") end),

})
-- }}}
 
-- Awesome keybinds
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift" }, "p",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
})

-- Tags switch keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Comma",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Period",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
})

-- Tag Keybinds
 awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})

-- Layout keybindings

awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- Change window width --
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    -- Move windows to left side --
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    -- Move windows to right side --
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    -- Change layout --
    awful.key({ modkey,           }, "grave", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "grave", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
})

-- Focus related keybindings

awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "c",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey, "Shift" }, "c",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
--   awful.key({ modkey,           }, "c",
--       function ()
--           awful.client.focus.history.previous()
--           if client.focus then
--               client.focus:raise()
--           end
--       end,
--       {description = "go back", group = "client"}),
    awful.key({ modkey, }, "z",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "client"}),
})

--  Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mainmenu:toggle() end),
--   awful.button({ }, 4, awful.tag.viewprev),
--   awful.button({ }, 5, awful.tag.viewnext),
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

