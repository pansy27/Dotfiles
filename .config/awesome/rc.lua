pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")

local gears = require("gears")

-- required for sending error messages( can't figure out how to theme them wihtout breaking functionality)
require("signals.errors")

-- Allow Awesome to automatically focus a client upon changing tags or loading.
require("awful.autofocus")

-- Enable hotkeys help widget for VIM and other apps when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Bindings
require("binds")

-- Config
require("config")

-- menu???
require("config.menu")

-- Signals 
require("signals")

-- Sidebar
require("my-widgets.sidebar")

-- Music widget
require("my-widgets.music_player")

-- Custom Icons
require("icon_customizer"){
   	delay = 0.2	 }

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
	timeout = 30,
	autostart = true,
	callback = function() collectgarbage() end
}

