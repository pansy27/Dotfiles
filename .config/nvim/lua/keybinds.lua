-- setting custom keybinds

local k = vim.keymap.set

-- setting leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- quickly escape insert mode
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true })

-- for buffers
local map = vim.api.nvim_set_keymap

map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
map("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
map("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })

for i = 1, 9 do
  map(
    "n",
    ("<F%s>"):format(i),
    ("<Plug>(cokeline-focus-%s)"):format(i),
    { silent = true }
  )
  map(
    "n",
    ("<Leader>%s"):format(i),
    ("<Plug>(cokeline-switch-%s)"):format(i),
    { silent = true }
  )
end

k({'n', 'v'}, '<Leader>x', '<cmd>:bd<CR>')

-- for splits
k({'n', 'v'}, '<Leader>wv', '<cmd>:vsplit<CR>', { silent = true })
k({'n', 'v'}, '<Leader>ws', '<cmd>:split<CR>', { silent = true })
k({'n', 'v'}, '<Leader>wc', '<cmd>:close<CR>', { silent = true })
k({'n', 'v'}, '<Leader>wq', '<cmd>:exit<CR>', { silent = true })
k({'n', 'v'}, '<Leader>h', '<cmd>:new term://zsh<CR>')
k({'n', 'v'}, '<Leader>v', '<cmd>:vnew term://zsh<CR>')

-- moving around in splits
k('n', '<Leader>wh', '<C-w>h<CR>')
k('n', '<Leader>wj', '<C-w>j<CR>')
k('n', '<Leader>wk', '<C-w>k<CR>')
k('n', '<Leader>wl', '<C-w>l<CR>')

-- resize split 
k({'n', 'v'}, '<space>Left', '<cmd>:vertical resize +3<CR>', { silent = true })
k({'n', 'v'}, '<space>Right', '<cmd>:vertical resize -3<CR>', { silent = true })
k({'n', 'v'}, '<space>Up', '<cmd>:resize +3<CR>', { silent = true })
k({'n', 'v'}, '<space>Down', '<cmd>:resize -3<CR>', { silent = true })

-- others 
k('t', '<Esc>', '<C-\\><C-n><CR>') -- escape terminal mode
k('n', '<Leader>e', ':E<CR>') -- netrw

-- stolen
k('i', '<C-a>', '<Esc>I')
k('i', '<C-e>', '<Esc>A')

-- move lines in visual mode
k("v", "J", ":m '>+1<CR>gv=gv")
k("v", "K", ":m '<-2<CR>gv=gv")

-- greatest remap ever
k("x", "<Leader>p", "\"_dP") -- paste over without copying the deleted selection

-- yank shortcuts
k({ 'n', 'v' }, '<Leader>y', "\"+y")
