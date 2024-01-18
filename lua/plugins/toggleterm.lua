-- Terminal
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<leader>t]],
    }
  end,
}
