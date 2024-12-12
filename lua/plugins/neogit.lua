-- git
return {
  'TimUntersberger/neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  cmd = 'Neogit',
  keys = {
    { '<leader>g', '<cmd>Neogit<cr>', desc = 'Neogit' },
  },
  config = true,
}
