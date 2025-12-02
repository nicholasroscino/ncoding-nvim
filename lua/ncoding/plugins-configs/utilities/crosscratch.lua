-- In your main config (e.g., ~/.config/nvim/init.lua) or plugin definition file

return {

	{
		dir = "~/.config/nvim/lua/ncoding/src/crosscratch",
		name = "crosscratch",
		config = function()
			local crosscratch = require("ncoding.src.crosscratch")

			vim.api.nvim_create_user_command(
				"ScratchFind",
				crosscratch.find_scratch_file,
				{ desc = "Find and open an existing cross-project scratch file" }
			)

			-- Define the command for creating a new file (Updated to use the prompt function)
			vim.api.nvim_create_user_command(
				"ScratchNew",
				crosscratch.new_scratch_file_prompt,
				{ desc = "Create a new cross-project scratch file using a pop-up prompt" }
			)

			-- Optional: Define keybindings (Now much simpler)
			vim.keymap.set("n", "<leader>ns", ":ScratchNew<CR>", { desc = "New Scratch File (Prompt)" })
		end,
	},
}

-- Define the command for finding existing files (Unchanged)
