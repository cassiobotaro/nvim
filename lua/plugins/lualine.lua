-- statusline
vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

require('lualine').setup {
  options = { section_separators = '', component_separators = '|', theme = 'onedark' },
}
