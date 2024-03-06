-- installing lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS BEGIN ---
require("lazy").setup({

-- colorsheme (brownish)
{
    "ramojus/mellifluous.nvim",
    dependencies = {
        'rktjmp/lush.nvim'
    },
},

-- colorscheme (both)
{
    "projekt0n/github-nvim-theme",
},

-- colorscheme (light/dark)
{
    'rose-pine/neovim',
    name = 'rose-pine'
},

-- solarized(blud really??? 💀)
{
    'calind/selenized.nvim',
},

-- colorscheme (dark)
{
    'rockerBOO/boo-colorscheme-nvim',
},

-- colorscheme (dark)
{
    'sainnhe/sonokai', -- literally classic monokai
},

-- colorscheme (light/dark)
{
    'mcchrish/zenbones.nvim',
},

-- colorscheme (dark?)
{
    'navarasu/onedark.nvim',
},
-- colorscheme (dark)
{
    'loctvl842/monokai-pro.nvim',
},

-- xresources?
{
    'ricewind012/xresources-nvim',
},

-- funky bufferline
{
    "willothy/nvim-cokeline",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = true
},

-- fuzzy finder
{
    'nvim-telescope/telescope.nvim',
    keys = "<Leader>f",
    dependencies = { 'nvim-lua/plenary.nvim' }
},

-- fzf for telescope
{
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
        return vim.fn.executable 'make' == 1
    end,
},
{
    'nvim-telescope/telescope-ui-select.nvim',
},
-- which keys cause i forget
{
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
    }
},

-- statusline
{
    'nvim-lualine/lualine.nvim',
},

-- Add indentation guides even on blank lines
{
    "lukas-reineke/indent-blankline.nvim" ,
    event = "BufReadPre",
},

-- comments
{
    'numToStr/Comment.nvim',
    event = "BufReadPre",
    opts = {},
},

--[[ git signs
{
    'lewis6991/gitsigns.nvim',
},
]]--

{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
},
-- ide shit
    -- treesitter for some graph shit and good syntax highlight
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
},
    -- mason for lsp servers and stuff
{
    "williamboman/mason.nvim",
},

    -- ???
{
    'williamboman/mason-lspconfig.nvim',
},
    -- ???
{
    "neovim/nvim-lspconfig",
},
{
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- configurations go here
  },
},
})
