return {
  {
    dir = '~/.config/nvim/lua/ncoding/src/get-online-ref',
    name = 'get-online-search',
    depenencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('ncoding.src.get-online-ref').setup()
    end,
  },
}
