---------------------------
-- My light theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/cinnamonroll/"

local common = require("my-widgets.common")
local theme = {}

theme.font_reg     = "Google Sans "
theme.font_med     = "Google Sans, Medium "
theme.font_bold    = "Google Sans, Bold "
theme.font_nerd    = "Symbols Nerd Font Mono "
theme.font         = "IBM Plex Sans Medium 10"

theme.colors = {
   slate_grey = "#6a7895",
   my_white = "#f9fbff",
   cinnamon_white = "#fafafa",
   blue = "#b3c4e2",
   light_blue = "#d3dceb",
   dark_blue = "#545f6e",
   purple = "#ebdae3",
   dark_purple = "#d8b6e5",
   app_bg = "#e9f1fb",
   silly_bg = "#dfe7f2",
   silly_fg = "#556070",

   slider = {
      active = "#a1afcb",
      inactive = "#c8c8c8",
      dot = "#96a1bc",
      border = "#94add7b3"
   }
}

theme.fg_1 = theme.colors.slate_grey
theme.fg_2 = theme.colors.my_white
theme.fg_3 = theme.colors.dark_blue
theme.blue_1 = theme.colors.blue
theme.blue_2 = theme.colors.light_blue

-- Widgets vars
theme.sidebar_icons = themes_path .. "widgets/sidebar/"
theme.player_icons = themes_path .. "widgets/music_player/"

-- Music player
theme.player_bg = theme.colors.cinnamon_white
theme.player_fg = theme.colors.silly_bg
theme.player_button = theme.colors.cinnamon_white

-- Rest
theme.bg_normal     = theme.colors.cinnamon_white
theme.bg_focus      = theme.colors.cinnamon_white
theme.bg_urgent     = theme.colors.blue
theme.bg_minimize   = theme.colors.cinnamon_white
theme.bg_systray    = theme.bg_normal

theme.fg_focus      = theme.colors.silly_fg
theme.fg_normal     = theme.colors.slate_grey
theme.fg_urgent     = theme.colors.silly_fg
theme.fg_minimize   = "grey"

theme.useless_gap         = dpi(0)
theme.border_width        = dpi(2)
theme.border_color_active = theme.colors.cinnamon_white
theme.border_color_normal = theme.colors.blue
theme.border_color_marked = theme.colors.purple

-- Titlebars
theme.titlebar_bg_focus = theme.colors.blue
theme.titlebar_bg_normal = theme.colors.light_blue

-- Need all cause awesome complains if they're absent
-- close button
theme.titlebar_close_button_normal  = themes_path .. "titlebar/close.svg"
theme.titlebar_close_button_focus  = themes_path .. "titlebar/close.svg"

-- minimize button
theme.titlebar_minimize_button_normal_active   = themes_path .. "titlebar/minimize.svg"
theme.titlebar_minimize_button_normal_inactive   = themes_path .. "titlebar/minimize.svg"
theme.titlebar_minimize_button_focus_active   = themes_path .. "titlebar/minimize.svg"
theme.titlebar_minimize_button_focus_inactive   = themes_path .. "titlebar/minimize.svg"

-- maximized (if ever needed)
--[[ theme.titlebar_maximized_button_normal_inactive = themes_path .. "titlebar/maximized.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "titlebar/maximized.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "titlebar/maximized.png"
theme.titlebar_maximized_button_focus_active  = themes_path .. "titlebar/maximized.png" ]]


-- Notifications
theme.notification_position = "top_right"
theme.notification_bg = theme.colors.cinnamon_white
theme.notification_fg = theme.colors.silly_fg
theme.notification_border_width = 0
-- theme.notification_border_color = ""
theme.notification_font = theme.font_med .. "10"
theme.notification_margin = 400

theme.notification_action_underline_normal = false

-- Taglist 
theme.taglist_fg_focus = theme.colors.dark_blue
theme.taglist_fg_empty = theme.colors.slider.inactive
theme.taglist_fg_occupied = theme.colors.blue

-- Tasklist 
theme.tasklist_plain_task_name = true

-- Layout box icons
theme.layout_floating  = themes_path.."layouts/floating.svg"
theme.layout_max = themes_path.."layouts/maximized.svg"
theme.layout_fullscreen = themes_path.."layouts/fullscreenw.svg"
theme.layout_tile = themes_path.."layouts/tile.svg"

-- Wibar
theme.wibar_shape = common.rrect(5)

-- Menu
theme.menu_submenu_icon = themes_path.."menu-light.svg"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(120)

-- Awesomewm icon
theme.awesome_icon = themes_path .. "icon.svg"

-- doesn't work anyways :(
theme.icon_theme = nil

-- Custom icons for clients
local icon_dir = themes_path .. "apps/"
theme.ic_icons = {
   ["Alacritty"] = icon_dir .. "terminal.png",
   ["Emacs"] = icon_dir .. "editor.png",
   ["VSCodium"] = icon_dir .. "editor.png",
   ["Chromium"]  = icon_dir .. "chromium.png",
   ["Thunar"] = icon_dir .. "files.png",
   ["mpv"] = icon_dir .. "video.png",
   ["Pavucontrol"] = icon_dir .. "volume.png",

}
theme.ic_dynamic_classes = {
   "Alacritty",
   "Chromium"
}
theme.ic_dynamic_icons = {
   ["ncmpcpp"] = icon_dir .. "music.png",
   ["r/unixporn"] = icon_dir .. "reddit.png",
   ["Spotify"] = icon_dir .. "spotify.png",
   ["Discord"] = icon_dir .. "discord.png",
   ["Google"] = icon_dir .. "google.png",
   ["YouTube"] = icon_dir .. "youtube.png",
   ["Twitch"] = icon_dir .. "twitch.png",
   ["Twitter"] = icon_dir .. "twitter.png",
   ["Pinterest"] = icon_dir .. "pinterest.png",
}
theme.ic_fallback_icon = icon_dir .. "default.png"

return theme
