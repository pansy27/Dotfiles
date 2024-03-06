-- User apps
local apps = {}
apps.terminal = "alacritty"
apps.editor = os.getenv("EDITOR") or "nvim"
apps.editor_cmd = apps.terminal .. " -e " .. apps.editor

return apps
