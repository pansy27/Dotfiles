-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  -- group = Util.augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual" })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  -- group = Util.augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  -- group = Util.augroup("close_with_q"),
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- fix comment on new line
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd([[set formatoptions-=cro]])
  end,
})

