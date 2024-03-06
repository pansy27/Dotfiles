require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "cpp", "lua", "javascript", "html", "vim", "vimdoc", "query" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
}

