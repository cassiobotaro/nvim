vim.g.mapleader = ' ' -- space as leader key
vim.g.maplocalleader = ' ' -- space as leader key
vim.g.copilot_enabled = true -- enable copilot

-- register filetypes not built-in to Neovim
vim.filetype.add {
  filename = {
    ['go.work'] = 'gowork',
    ['go.work.sum'] = 'gowork',
  },
  extension = {
    gotmpl = 'gotmpl',
  },
}
