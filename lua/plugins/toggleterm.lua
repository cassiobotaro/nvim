-- Terminal
vim.pack.add { 'https://github.com/akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  direction = 'float',
  open_mapping = [[<c-\>]],
}
