require('mason').setup {

}

require('mason-lspconfig').setup {
    ensure_installed = { "clangd", "lua_ls", --[[ "tsserver" ]] },
}

fuck = "this_hsot";
-- lsp server shit for neovim
-- Setup language servers.
local lspconfig = require('lspconfig');
lspconfig.clangd.setup {};
lspconfig.lua_ls.setup {};

-- mason keybinds
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
-- vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<Leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action)
--[[ vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references) ]]--
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
