-- At first, you need to require tym module
local tym = require('tym')
-- set individually
--tym.set('width', 100)

tym.set('font', 'Monospace 11.5')

-- set by table
tym.set_config({
    -- shell = '/usr/bin/fish',
    cursor_shape = 'block',
    cursor_blink_mode = 'on',
    autohide = true,
    background_image = '/home/anon/pictures/others/to_be_made/lain.jpg',
    padding_left = 15,
    padding_right = 15,
    padding_top = 15,
    padding_bottom = 15,
    color_window_background = '#343434',

    scrollback_length = 8096,

    -- Change paste keybind
})
tym.set_keymap('<Ctrl>v', function()
  tym.paste()
end)
