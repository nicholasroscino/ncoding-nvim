vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- TODO: Understand if I care about this if I use something like Trouble
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'ge', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Next Error' })

vim.keymap.set('n', 'gE', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Prev Error' })

vim.keymap.set('n', '}', '5k')
vim.keymap.set('n', '{', '5j')

-- NOTE: Command+/ -- comment lines easier. This is intended to work with escape sequence in iterm2 using tmux over ssh
--vim.keymap.set("v", "<ESC>Գ", "gc",{silent = true, remap = true})
--vim.keymap.set("n", "<ESC>Գ", "gcc",{silent = true, remap = true})

-- NOTE: Alt+2 -- Explain error at cursor. This is intended to work with escape sequence in iterm2 using tmux over ssh
-- vim.keymap.set("n", "<ESC>Ե", function()
--   vim.diagnostic.open_float()
-- end, { desc = "Open diagnostic under cursor" })

-- NOTE: This is quick close mostly for Git Diff with fugitive. Probably useless since theres a diffclose or something like that.
vim.api.nvim_create_user_command('QQ', function()
  vim.cmd ':q|q'
end, {})

-- NOTE: Removed since now we use <ESC> to be sure this is possible when using escape sequence.
--vim.keymap.set('t', '<C-\\>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-\\>', ':belowright split | resize 15 | term<CR>')
-- vim.keymap.set("n", "<F13>", ":Git<CR>")

-- move "easier" between the splits. CTRL-H doesn't work when oil in split
vim.keymap.set('n', '<Up>', '<C-w>k')
vim.keymap.set('n', '<Down>', '<C-w>j')
vim.keymap.set('n', '<Left>', '<C-w>h')
vim.keymap.set('n', '<Right>', '<C-w>l')
vim.keymap.set('n', '<C-n>', 'zR')
-- vim.keymap.set("n", "<C-/>", "zM")
vim.keymap.set('n', '<C-l>', 'zA')
vim.keymap.set('n', '<C-k>', 'zk')
vim.keymap.set('n', '<C-j>', 'zj')
vim.keymap.set('n', '<leader>fw', 'yiw/<C-r>"<CR>')
