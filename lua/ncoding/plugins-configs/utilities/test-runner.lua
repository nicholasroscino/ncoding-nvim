return {
	{
		dir = "~/.config/nvim/lua/ncoding/src/test-runner",
		name = "test-runner",
		config = function()
			require("ncoding.src.test-runner").setup()
		end,
	},
}
