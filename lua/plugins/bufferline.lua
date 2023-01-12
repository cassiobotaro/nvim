-- buffer tabs
return {
  'akinsho/bufferline.nvim',
  version = 'v3.*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup()
  end,
}
