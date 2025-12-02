local M = {}

local function get_current_file()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		return nil
	end
	return file
end

function run_cc_test(file, mode)
	if not string.find(file, ".test") then
		print("Not a test file")
		return
	end

	local line_num = vim.fn.line(".")
	local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

	local match_it = "[it]%([`'\"](.-)[`'\"]"
	local fallback_on_describe = "[describe]%([`'\"](.-)[`'\"]"

	local captured_text = string.match(line_text, match_it)

	if captured_text then
		captured_text = '"' .. captured_text .. '"'
	else
		captured_text = string.match(line_text, fallback_on_describe)
		if captured_text then
			captured_text = '"' .. captured_text .. '"'
		end
	end

	local cmd = { "npm", "run", "test", "--", file, "--grep", captured_text }
	if mode == "debug" then
		table.insert(cmd, "--debug")
	end

	local commandString = "belowright split | term"

	for i = 1, #cmd do
		commandString = commandString .. " %s"
	end

	commandString = string.format(commandString, unpack(cmd))
	vim.cmd(commandString)
end

function run_js_test(file, mode)
	if not string.find(file, ".test") then
		print("Not a test file")
		return
	end

	local line_num = vim.fn.line(".")
	local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

	local match_it = "[it]%([`'\"](.-)[`'\"]"
	local fallback_on_describe = "[describe]%([`'\"](.-)[`'\"]"

	local captured_text = string.match(line_text, match_it)

	if captured_text then
		captured_text = '"' .. captured_text .. '"'
	else
		captured_text = string.match(line_text, fallback_on_describe)
		if captured_text then
			captured_text = '"' .. captured_text .. '"'
		end
	end

	local cmd = { "npm", "run", "test", "--", file, "--grep", captured_text }
	if mode == "debug" then
		table.insert(cmd, "--debug")
	end

	local commandString = "belowright split | term"

	for i = 1, #cmd do
		commandString = commandString .. " %s"
	end

	commandString = string.format(commandString, unpack(cmd))
	vim.cmd(commandString)
end

function M.run_test(mode)
	local file = get_current_file()
	if not file then
		print("No file found")
		return
	end

	if string.find(file, ".js") or string.find(file, ".ts") then
		run_js_test(file, mode)
	elseif string.find(file, ".cpp") or string.find(file, ".cc") then
		run_cc_test(file, mode)
	end
end

function M.setup()
	vim.api.nvim_create_user_command("RunTest", function(opts)
		M.run_test(opts.args)
	end, { nargs = "?" })
end

return M
