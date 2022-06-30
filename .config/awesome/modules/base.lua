local beautiful = require("beautiful")
-- Theme 
beautiful.init("~/.config/awesome/themes/yumeko/theme.lua")
-- Default terminal and editor
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
--editor_cmd = terminal .. " -e " .. editor
editor_cmd = editor
-- Mod key
modkey = "Mod4"

