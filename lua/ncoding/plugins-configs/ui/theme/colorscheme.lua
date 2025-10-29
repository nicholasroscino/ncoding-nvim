return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- load immediately on startup
		priority = 1000, -- make sure it loads before other plugins
		-- config = function()
		--     -- Optional: choose a style: storm, night, day
		--     vim.g.tokyonight_style = "storm"

		--     -- Apply the colorscheme
		--     vim.cmd("colorscheme tokyonight")
		-- end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.25, -- percentage of the shade to apply to the inactive window
			},
		},
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
			})

			vim.cmd("colorscheme catppuccin")
		end,
	},
}
