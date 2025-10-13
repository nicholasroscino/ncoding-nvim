return {
  {
    dir = '~/.config/nvim/lua/ncoding/src/command-search',
    name = 'command-search',
    depenencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('ncoding.src.command-search').setup {
        commands = {
          { name = 'Format', desc = 'Format current buffer', cmd = 'ConformFormat' },
          { name = 'Test', desc = 'Run tests', cmd = 'RunTest' },
          { name = 'GitLink', desc = 'Get github code link', cmd = 'CopyGithubRef' },
          { name = 'ChromiumCodeSearchLink', desc = 'Get chromium codesearch link', cmd = 'CopySourceRef' },
        },
      }

      vim.keymap.set('n', '<leader>sa', ':MyCommands<CR>', { desc = 'Find keymap by description' })
    end,
  },
}
