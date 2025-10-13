local M = {}
local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

M._commands = {}

function M.setup(opts)
  M._commands = opts.commands or {}

  vim.api.nvim_create_user_command('MyCommands', function()
    M.show()
  end, {})
end

function M.show(opts)
  opts = opts or {}

  if vim.tbl_isempty(M._commands) then
    vim.notify('No commands registered in mycommands', vim.log.levels.WARN)
    return
  end

  pickers
    .new(opts, {
      prompt_title = 'My Commands',
      finder = finders.new_table {
        results = M._commands,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format('%-20s %s', entry.name, entry.desc or ''),
            ordinal = (entry.name or '') .. ' ' .. (entry.desc or ''),
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local selection = action_state.get_selected_entry().value
          actions.close(prompt_bufnr)
          vim.cmd(selection.cmd)
        end)
        return true
      end,
    })
    :find()
end

return M
