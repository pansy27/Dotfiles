-- At first, you need to require tym module
local tym = require('tym')

-- set individually
--tym.set('width', 100)

tym.set('font', 'CozetteVector 9')

-- set by table
tym.set_config({
  shell = '/usr/bin/zsh',
--  cursor_shape = 'underline',
  autohide = true,
  padding_horizontal = 15,
  padding_vertical = 15,
--  color_foreground = 'red',

-- Change paste keybind
})
tym.set_keymap('<Ctrl>v', function()
  tym.paste()
end)
