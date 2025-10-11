local M = {}

local Popup = require 'nui.popup'
local oil = require 'oil'

local json_file = vim.fn.stdpath 'data' .. '/projects.json'

local function load_projects()
  local f = io.open(json_file, 'r')
  if not f then
    return {}
  end
  local content = f:read '*a'
  f:close()
  local ok, decoded = pcall(vim.fn.json_decode, content)
  return ok and decoded or {}
end

local function save_projects(projects)
  local f = io.open(json_file, 'w')
  if not f then
    return
  end
  f:write(vim.fn.json_encode(projects))
  f:close()
end

function M.get_projects()
  return load_projects()
end

function M.add_project(name, path)
  local projects = load_projects()
  projects[name] = { path = path, visible = true }
  save_projects(projects)
end

function M.set_visible(name, visible)
  local projects = load_projects()
  if projects[name] then
    projects[name].visible = visible
    save_projects(projects)
  end
end

function M.show_ui()
  local projects = load_projects()
  local names = vim.tbl_keys(projects)

  local popup = Popup {
    enter = true,
    focusable = true,
    border = {
      style = 'rounded',
      text = {
        top = ' Projects ',
        top_align = 'center',
      },
    },
    position = '50%',
    size = {
      width = 60,
      height = 15,
    },
  }

  popup:mount()

  vim.bo[popup.bufnr].buftype = 'nofile'
  vim.bo[popup.bufnr].bufhidden = 'wipe'
  vim.bo[popup.bufnr].swapfile = false
  vim.bo[popup.bufnr].modifiable = true
  vim.bo[popup.bufnr].readonly = false
  vim.bo[popup.bufnr].filetype = 'ProjectList'

  local function render()
    vim.bo[popup.bufnr].modifiable = true
    vim.bo[popup.bufnr].readonly = false

    local lines = {}
    for _, name in ipairs(names) do
      local info = projects[name]
      local icon = info.visible and '✅' or '❌'
      table.insert(lines, string.format('%s %s -> %s', icon, name, info.path))
    end
    if #lines == 0 then
      lines = { 'No projects found.' }
    end

    vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)

    vim.bo[popup.bufnr].modifiable = false
    vim.bo[popup.bufnr].readonly = true
  end

  render()

  vim.wo[popup.winid].cursorline = true

  popup:map('n', 'q', function()
    popup:unmount()
  end, { noremap = true })

  popup:map('n', 'j', 'j', { noremap = true })
  popup:map('n', 'k', 'k', { noremap = true })

  popup:map('n', 'v', function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local project_name = names[row]
    local project = projects[project_name]
    if project then
      project.visible = not project.visible
      save_projects(projects)
      render()
    end
  end, { noremap = true })

  popup:map('n', '<CR>', function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local project_name = names[row]
    local project = projects[project_name]
    if project then
      popup:unmount()
      vim.api.nvim_set_current_dir(project.path)
      oil.open(project.path)
      print('Changed directory to ' .. project.path)
    end
  end, { noremap = true })
end

function M.setup()
  vim.api.nvim_create_user_command('ProjectAdd', function(opts)
    local cwd = vim.fn.getcwd()
    M.add_project(opts.args ~= '' and opts.args or vim.fn.fnamemodify(cwd, ':t'), cwd)
  end, { nargs = '?' })

  vim.api.nvim_create_user_command('ProjectVisible', function(opts)
    M.set_visible(opts.args, true)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('ProjectHidden', function(opts)
    M.set_visible(opts.args, false)
  end, { nargs = 1 })

  vim.api.nvim_create_user_command('ProjectList', function()
    M.show_ui()
  end, {})
end

return M
