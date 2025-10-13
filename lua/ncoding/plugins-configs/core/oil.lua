return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      local oil = require 'oil'

      oil.setup {
        view_options = {
          show_hidden = true,
        },
      }

      vim.keymap.set('n', '<leader>pv', function()
        oil.open(vim.fn.expand '%:p:h') -- open oil at current working directory
      end, { desc = 'Open Oil in CWD' })

      -- vim.keymap.set("n", "<leader>pv", vim.oil.actions.open_cwd(), { desc = "Open cwd directory" })
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
