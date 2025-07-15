return {
  'olimorris/codecompanion.nvim',
  event = 'VeryLazy',
  opts = {
    strategies = {
      chat = { adapter = 'copilot' },
      inline = { adapter = 'copilot' },
      agent = { adapter = 'copilot' },
    },
  },
  keys = {
    { '<leader>ccc', ':CodeCompanionChat Toggle<CR>', { 'n', 'v' }, silent = true },
    { '<leader>cca', ':CodeCompanionActions<CR>', { 'n', 'v' }, silent = true },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
}
