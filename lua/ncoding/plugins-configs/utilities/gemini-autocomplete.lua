return {
	{
		"flyingshutter/gemini-autocomplete.nvim",
		opts = {},
		config = function()
			local gemini = require("gemini-autocomplete")

			gemini.setup({
				completion = { enabled = false },
			})
		end,
	},
}
