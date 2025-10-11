return {
  {
    dir = '~/.config/nvim/lua/ncoding/src/project-list',
    name = 'project-list',
    depenencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('ncoding.src.project-list').setup {}
    end,
  },
}
