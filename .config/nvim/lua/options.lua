-- settings vars
local o = vim.opt
local g = vim.g

-- setting some options
-- See `:help vim.o`
o.mouse = "a"
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.autoindent = true
o.smartindent = true
o.scrolloff =  8

-- tabs
o.smarttab = true
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

-- split direction
o.splitbelow = true
o.splitright = true

--o.syntax = "off"
-- o.clipboard = "unnamedplus"

-- Save undo history
o.undofile = true

-- Enable break indent
o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'   --used by plugins. ex- git changes, lsp hints etc like in vscode

-- Set highlight on search
o.hlsearch = false
o.incsearch = true

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

-- Decrease update time
o.updatetime = 50
--o.timeout = true
--o.timeoutlen = 300

-- restoring cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  command = [[if line("'\"") > 1 && line("'\"") <= line('$') && &filetype !~# 'commit' | exe 'normal! g`"' | endif]],
  desc = "restore cursor location",
  group = vim.api.nvim_create_augroup("jump", {}),
})

-- whatever
o.termguicolors = true

-- neovide options
o.guifont = "Iosevka Moe:h10"
g.neovide_transparency = 0.6
g.neovide_hide_mouse_while_typing = true
g.neovide_cursor_antialiasing = false
