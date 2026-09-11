vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

require('render-markdown').setup {
  render_modes = true,
  sign = { enabled = false },
  latex = { enabled = false }, -- no latex tooling installed; silences the checkhealth warnings
}
