return {
	{
		dir = "~/.config/nvim/lua/ncoding/src/command-search",
		name = "command-search",
		depenencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("ncoding.src.command-search").setup({
				commands = {
					{ name = "Format", desc = "Format current buffer", cmd = "ConformFormat" },
					{ name = "Test", desc = "Run test at line", cmd = "RunTest" },
					{ name = "Debug", desc = "Debug test on line", cmd = "RunTest debug" },
					{ name = "GitLink", desc = "Get github code link", cmd = "CopyGithubRef" },
					{ name = "ChromiumCodeSearchLink", desc = "Get chromium codesearch link", cmd = "CopySourceRef" },
					{ name = "Diagnostics", desc = "Open diagnostics", cmd = "Trouble diagnostics" },
					{ name = "VSplitTerm", desc = "Open terminal vertical split", cmd = "vsplit|term" },
					{ name = "HSplitTerm", desc = "Open terminal horizontal split", cmd = "split|term" },
				},
			})

			vim.keymap.set("n", "<leader>sa", ":MyCommands<CR>", { desc = "Find keymap by description" })
		end,
	},
}
