return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  ft = { 'markdown' },
  opts = {
    render_modes = true,
    sign = { enabled = false },
  },
}
