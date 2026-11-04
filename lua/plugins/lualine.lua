-- statusline
vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

require('lualine').setup {
  options = { section_separators = '', component_separators = '|', theme = 'onedark' },
  sections = {
    lualine_c = {
      'filename',
      { vim.lsp.status, icon = '' },
    },
    lualine_x = {
      -- shows provider:model and a spinner while a request is in flight
      require 'minuet.lualine',
      'encoding',
      'fileformat',
      'filetype',
    },
  },
}
