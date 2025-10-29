vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Create an autocommand group to avoid duplicates
local spellTerminalGroup = vim.api.nvim_create_augroup("DisableSpellInTerminal", { clear = true })

-- Create the autocommand
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*", -- Trigger for any terminal
	callback = function()
		vim.opt_local.spell = false -- Set 'nospell' only for this buffer
	end,
	group = spellTerminalGroup,
})

require("ncoding.autocommands.string_interpolation_autocmd")
require("ncoding.autocommands.quickfix_easy_close")
