return {
	{
		"folke/trouble.nvim",
		config = function()
			local trouble = require("trouble")
			trouble.setup({})

			vim.api.nvim_set_keymap("n", "<Leader>xw", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap(
				"n",
				"<Leader>xd",
				"<Cmd>Trouble filter.buf=0<CR>",
				{ silent = true, noremap = true }
			)
			vim.api.nvim_set_keymap("n", "<Leader>xl", "<Cmd>Trouble loclist<CR>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<Leader>xq", "<Cmd>Trouble quickfix<CR>", { silent = true, noremap = true })

			vim.keymap.set("n", "<leader>tt", function()
				trouble.toggle()
			end, { desc = "toggle trouble" })

			vim.keymap.set("n", "[t", function()
				trouble.next({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "]t", function()
				trouble.previous({ skip_groups = true, jump = true })
			end)
		end,
	},
}
