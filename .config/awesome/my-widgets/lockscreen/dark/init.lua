local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")


-- User modules
local common = require("my-widgets.common")
local popup = require("my-widgets.lockscreen.dark.popup")
local user = require("user")



-- main lockscreen
local lockScreen = wibox {
	visible = false,
	bg = beautiful.colors.cinnamon_white,
	ontop = true,
	height = dpi(768),
	width = dpi(1366),
	placement = awful.placement.centered
}

local lockScreenImg = wibox.widget {
	image = beautiful.lockscreen_bg,
	widget = wibox.widget.imagebox
}

---- finalizing lockscreen -----------
lockScreen:setup {
	lockScreenImg,
	popup.passwordBox,
	layout = wibox.layout.stack,
}

collectgarbage()

-- toggle lockscreen
function lockScreen_visibility()
	if lockScreen.visible == true then
		lockScreen.visible = false
	else
		lockScreen.visible = true
		awful.spawn('playerctl -a pause')
		popup.passwdPrompt()
	end
end

-- characters entered
popup.characters_entered = 0

-- current password box input
local password_string = popup.passwdPrompt:get_children_by_id("passwd_box")[1]
local indicator_string = popup.passwdPrompt:get_children_by_id("passwd_indicator")[1]

local function reset(icon)
	password_string.markup = ""
	if icon == true then
		indicator_string:set_image(gears.surface.load_uncached(beautiful.lockscreen_lock))
	end
end


function popup.passwdPrompt()
	awful.prompt.run {
		textbox = wibox.widget.textbox(),
		hooks = {
			{ {}, 'Escape', function(_)
				popup.characters_entered = 0
				reset(false)
				popup.passwdPrompt()
			end
			}
		},
		exe_callback = function(input)
			if not input or #input == 0 then return end
			if tonumber(input) == user.pin then
				lockScreen_visibility()
				reset(true)
			else
				reset(false)
				-- TODO: same here
				-- indicator_string.markup = "˙◠˙"
				indicator_string:set_image(gears.surface.load_uncached(beautiful.lockscreen_lock_alt))
				popup.passwdPrompt()
			end
		end,
		keypressed_callback = function(mod, key, command)
			if #key == 1 then
				popup.characters_entered = popup.characters_entered + 1
				password_string.markup = password_string.markup .. "*"
			elseif key == "BackSpace" then
				if popup.characters_entered >= 1 then
					popup.characters_entered = popup.characters_entered - 1
					password_string.markup = string.rep('*', popup.characters_entered)
				end
			end
		end
	}
end
