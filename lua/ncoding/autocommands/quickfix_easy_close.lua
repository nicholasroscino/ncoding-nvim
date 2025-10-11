vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  group = vim.api.nvim_create_augroup("QuickfixClose", { clear = true }),
  callback = function()
    -- Map <Esc> to close the quickfix window in Normal mode
    vim.keymap.set("n", "<Esc>", "<cmd>cclose<CR>", { silent = true, buffer = true })
    
    -- Optional: Map 'q' to close the quickfix window, a common pattern
    vim.keymap.set("n", "q", "<cmd>cclose<CR>", { silent = true, buffer = true })
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
})
