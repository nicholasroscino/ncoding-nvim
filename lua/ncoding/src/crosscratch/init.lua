-- lua/crosscratch/init.lua

local M = {}

local scratch_dir = vim.fn.stdpath("data") .. "/crosscratch/"

local function ensure_scratch_dir()
	if vim.fn.isdirectory(scratch_dir) == 0 then
		vim.fn.mkdir(scratch_dir, "p")
	end
end

--- Opens a new scratch file after prompting the user for the file name.
function M.new_scratch_file_prompt()
	ensure_scratch_dir()

	-- Use vim.ui.input for a non-blocking prompt pop-up
	vim.ui.input({
		prompt = "Scratch Filename (e.g., notes.md or scratch.lua): ",
		default = os.date("scratch_%Y%m%d_%H%M%S.txt"), -- Provide a helpful default
	}, function(filename)
		-- The function is called with the user's input (or nil if canceled)
		if not filename or filename:match("^%s*$") then
			-- Input was nil (canceled) or empty/whitespace
			print("Scratch file creation canceled.")
			return
		end

		-- Construct the full path
		local fullpath = scratch_dir .. filename

		-- Check if the path contains directories (e.g., 'notes/test.md')
		local dir_path = fullpath:match("(.*/)")
		if dir_path and vim.fn.isdirectory(dir_path) == 0 then
			-- Create intermediate directories if necessary
			vim.fn.mkdir(dir_path, "p")
		end

		-- Open the new file
		vim.cmd("edit " .. fullpath)
		print("Created new scratch file: " .. fullpath)

		-- Optional: Set the filetype explicitly if the filename has an extension
		local filetype = filename:match("%.(.*)$")
		if filetype then
			vim.cmd("set filetype=" .. filetype)
		end
	end)
end

--- Opens a fuzzy-finder (like Telescope) to select an existing scratch file. (Unchanged)
function M.find_scratch_file()
	ensure_scratch_dir()
	-- ... (Telescope logic remains the same) ...
	local status_ok, telescope = pcall(require, "telescope.builtin")

	if status_ok then
		telescope.find_files({
			prompt_title = "Cross-Project Scratch Files",
			cwd = scratch_dir,
			file_ignore_patterns = { "%.swp$", "%.bak$" },
		})
	else
		vim.cmd("edit " .. scratch_dir)
		vim.notify("Telescope not found. Opened scratch directory instead.", vim.log.levels.WARN)
	end
end

return M
