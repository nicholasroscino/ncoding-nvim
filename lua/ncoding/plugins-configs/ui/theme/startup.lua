return {
  {
    'startup-nvim/startup.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
    config = function()
      local hhmm = os.date '%H:%M'
      local date = os.date '%d-%m-%y'

      local prjList = require 'ncoding.src.project-list'
      local headers = require 'ncoding.plugins-configs.ui.theme.headers'

      local projects = prjList.get_projects()
      local proj = {}

      for name, info in pairs(projects) do
        if info.visible == true then
          table.insert(proj, { name, "lua require('ncoding.plugins-configs.ui.theme.project-cd').moveToProject('" .. info.path .. "')", '-' })
        end
      end

      require('startup').setup {
        header = {
          type = 'text',
          oldfiles_directory = false,
          align = 'center',
          fold_section = false,
          title = 'Header',
          margin = 0,
          content = headers.ncoding,
          highlight = 'Statement',
          default_color = '',
          oldfiles_amount = 0,
        },
        header_2 = {
          type = 'text',
          oldfiles_directory = false,
          align = 'center',
          fold_section = false,
          title = 'Quote',
          margin = 0,
          content = require('startup.functions').quote(),
          highlight = 'Constant',
          default_color = '',
          oldfiles_amount = 0,
        },
        body = {
          type = 'mapping',
          oldfiles_directory = false,
          align = 'center',
          fold_section = false,
          title = 'Basic Commands',
          margin = 0,
          content = {
            { ' Recent Files', 'Telescope oldfiles', '<leader>of' },
            { ' File Browser', 'Telescope file_browser', '<leader>fb' },
            { ' Colorschemes', 'Telescope colorscheme', '<leader>cs' },
          },
          highlight = 'String',
          default_color = '',
          oldfiles_amount = 0,
        },
        projects = {
          type = 'mapping',
          oldfiles_directory = false,
          align = 'center',
          fold_section = false,
          title = 'Projects',
          margin = 0,
          content = proj,
          highlight = 'String',
          default_color = '',
          oldfiles_amount = 0,
        },
        footer = {
          type = 'text',
          oldfiles_directory = false,
          align = 'center',
          fold_section = false,
          title = 'Footer',
          margin = 0,
          content = { date .. ' - ' .. hhmm },
          highlight = 'Number',
          default_color = '',
          oldfiles_amount = 0,
        },

        options = {
          mapping_keys = true,
          cursor_column = 0.5,
          empty_lines_between_mappings = false,
          disable_statuslines = true,
          paddings = { 2, 2, 2, 2, 2 },
        },
        mappings = {
          execute_command = '<CR>',
          open_file = 'o',
          open_file_split = '<c-o>',
          open_section = '<TAB>',
          open_help = '?',
        },
        colors = {
          background = '#1f2227',
          folded_section = '#56b6c2',
        },
        parts = { 'header', 'header_2', 'projects', 'body', 'footer' },
      }
    end,
  },
}
