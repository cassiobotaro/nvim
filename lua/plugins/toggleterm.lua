-- Terminal
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      open_mapping = [[<c-t>]],
    }
  end,
}
