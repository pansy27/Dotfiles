local awful = require("awful")
local gears = require("gears")
local apps = require("config.apps")
local naughty = require("naughty")

local mod = require("binds.mod")
local alt = mod.alt
local modkey = mod.modkey
local shift = mod.shift
local ctrl = mod.ctrl

-- Garbage collector settings
local function print_awesome_memory_stats(message)
	print(os.date(), "\nLua memory usage:", collectgarbage("count"))
	out_string = tostring(os.date()) .. "\nLua memory usage:"..tostring(collectgarbage("count")).."\n"
	out_string = out_string .. "Objects alive:"
	print("Objects alive:")
	for name, obj in pairs{ button = button, client = client, drawable = drawable, drawin = drawin, key = key, screen = screen, tag = tag } do
			out_string =out_string .. "\n" .. tostring(name) .. " = " ..tostring(obj.instances())
			print(name, obj.instances())
	end
	naughty.notify({title = "Awesome WM memory statistics " .. message, text = out_string, timeout=20,hover_timeout=20})
end

-- volume
awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "F3", function()
		awful.spawn("wpctl set-volume @DEFAULT_SINK@ 5%+")
	end),
	awful.key({ modkey }, "F2", function()
		awful.spawn("wpctl set-volume @DEFAULT_SINK@ 5%-")
	end),
	awful.key({ modkey }, "F4", function()
		awful.spawn("wpctl set-mute @DEFAULT_SINK@ toggle")
	end),

	--rofi
	awful.key({ modkey }, "d", function()
		awful.spawn("rofi -show drun")
	end),
	awful.key({ alt }, "n", function()
		awful.spawn("rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'")
	end),
	awful.key({ alt }, "g", function()
		awful.spawn("rofimoji")
	end),
	-- brightness
	awful.key({}, "F9", function()
		awful.spawn("xbacklight -inc 10%")
	end),
	awful.key({}, "F6", function()
		awful.spawn("xbacklight -dec 10%")
	end),

	-- others
	awful.key({ modkey }, "e", function()
		awful.spawn("thunar")
	end),
	awful.key({ ctrl, shift }, "Escape", function()
		awful.spawn.with_shell(apps.terminal .. " -e btm")
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ alt }, "a", function()
		awful.spawn.with_shell("playerctl play-pause")
	end),
	awful.key({ modkey }, "v", function()
		awful.spawn.with_shell("loginctl lock-session")
	end, { description = "lock the screen" }),
	awful.key({}, "Print", function()
		awful.spawn.with_shell("maim -s -l -b 3 -c 0.3,0,0.5,0.7 | xclip -selection clipboard -t image/png")
	end, { description = "screenshot utility" }),
	awful.key({ shift }, "Print", function()
		awful.spawn.with_shell("maim -s -l -b 3 -c 0.3,0,0.5,0.7 | swappy -f -")
	end, { description = "screenshot utility" }),
	awful.key({ alt, ctrl }, "Delete", function()
		awful.spawn.with_shell("xkill")
	end, { description = "kill client" }),

	awful.key({ modkey }, "space", function()
		awful.spawn("vivaldi")
	end),
	awful.key({ alt }, "e", function()
		awful.spawn.with_shell("neovide")
	end, { description = "neovide" }),

	-- garbage collector popup 
	awful.key({"Mod4","Control" }, "b", function()
    print_awesome_memory_stats("Precollect")
    collectgarbage("collect")
    collectgarbage("collect")
    gears.timer.start_new(20, function()
        print_awesome_memory_stats("Postcollect")
        return false
    end)
	end, {description = "print awesome wm memory statistics", group="awesome"})
})
