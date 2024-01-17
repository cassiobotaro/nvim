-- FIle explorer
return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'NeoTree',
  branch = 'v3.x',
  keys = {
    { '<leader>ft', '<cmd>Neotree toggle<cr>', desc = 'Toggle file explorer' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
}
