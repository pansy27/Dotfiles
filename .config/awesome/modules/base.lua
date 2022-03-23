local beautiful = require("beautiful")
-- Theme 
beautiful.init("~/.config/awesome/themes/default/theme.lua")
beautiful.font = "Poppins 10"
-- Default terminal and editor
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "neovim"
editor_cmd = terminal .. " -e " .. editor
-- Mod key
modkey = "Mod4"

