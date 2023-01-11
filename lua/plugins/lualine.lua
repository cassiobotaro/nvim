-- statusline
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = {
    options = { section_separators = '', component_separators = '|', theme = 'onedark' },
 },
}
