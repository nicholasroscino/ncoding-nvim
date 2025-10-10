local custom_group = vim.api.nvim_create_augroup("StringConversionGroup", { clear = true })

local function convert_quotes_in_string()
    local line_num = vim.fn.line('.')
    local col = vim.fn.col('.')

    local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
    local pre_cursor_char = line_text:sub(col-1,col-1)

    if pre_cursor_char ~= '$' then
        return
    end

    local start_pos = nil

    for i = col - 2, 1, -1 do
        local char = line_text:sub(i, i)
        if char == "'" or char == '"' then
            start_pos = i
            break
        end
    end

    if not start_pos then
        return
    end

    local end_pos = nil
    for i = col, #line_text do
        local char = line_text:sub(i, i)
        if char == "'" or char == '"' then
            end_pos = i
            break
        end
    end

    if not end_pos then
        return
    end

    local content = line_text:sub(start_pos + 1, end_pos - 1)
    local new_line = line_text:sub(1, start_pos - 1) .. '`' .. content .. '`' .. line_text:sub(end_pos + 1)

    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {new_line})

    vim.api.nvim_win_set_cursor(0, {line_num, col-1})
end

vim.api.nvim_create_autocmd("TextChangedI", {
    group = custom_group,
    callback = convert_quotes_in_string,
    desc = "Converts strings with $ to backticks while in insert mode",
})
