local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local naughty = require("naughty")

-- User modules
local user = require("user")
local lockPopup = require("my-widgets.lockscreen.light.cloud")
local clockWidget = require("my-widgets.lockscreen.light.clock")


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
	lockPopup.cloudWidget,
	clockWidget,
	layout = wibox.layout.stack,
}

collectgarbage()

-- toggle lockscreen
function lockScreen_visibility()
	if lockScreen.visible == true then
		lockScreen.visible = false
		naughty.suspended = not naughty.suspended
	else
		lockScreen.visible = true
		awful.spawn('playerctl -a pause')
		lockPopup.passwdPrompt()
		naughty.suspended = not naughty.suspended
	end
end

-- characters entered
lockPopup.characters_entered = 0

-- current password box input
local password_string = lockPopup.promptBox:get_children_by_id("passwd_box")[1]
local indicator_string = lockPopup.promptBox:get_children_by_id("passwd_indicator")[1]

local function reset(icon)
	password_string.markup = ""
	if icon == true then
		indicator_string.markup = "♡"
	end	
end


function lockPopup.passwdPrompt()
	awful.prompt.run {
		textbox = wibox.widget.textbox(),
		hooks = {
			{ {}, 'Escape', function(_)
				lockPopup.characters_entered = 0
				reset(false)
				lockPopup.passwdPrompt()
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
				indicator_string.markup = "˙◠˙"
				lockPopup.passwdPrompt()
			end
		end,
		keypressed_callback = function(mod, key, command)
			if #key == 1 then
				lockPopup.characters_entered = lockPopup.characters_entered + 1
				password_string.markup = password_string.markup .. "*"
			elseif key == "BackSpace" then
				if lockPopup.characters_entered >= 1 then
					lockPopup.characters_entered = lockPopup.characters_entered - 1
					password_string.markup = string.rep('*', lockPopup.characters_entered)
				end
			end
		end
	}
end
