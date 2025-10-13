local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function keymaps_descriptions(opts)
  opts = opts or {}

  local keymaps = vim.api.nvim_get_keymap 'n' -- normal mode keymaps
  local entries = {}

  for _, map in ipairs(keymaps) do
    local desc = map.desc or ''
    if desc ~= '' then
      table.insert(entries, {
        display = desc,
        value = map,
        ordinal = desc,
      })
    end
  end

  pickers
    .new(opts, {
      prompt_title = 'Keymap Descriptions',
      finder = finders.new_table {
        results = entries,
        entry_maker = function(entry)
          return entry
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(_, map)
        map('i', '<CR>', function(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          print(('Pressed: %s → %s'):format(entry.value.lhs, entry.value.rhs))
        end)
        return true
      end,
    })
    :find()
end

return {
  keymaps_descriptions = keymaps_descriptions,
}
