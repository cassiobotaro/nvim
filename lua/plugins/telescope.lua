-- highly extendable fuzzy finder over lists
return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  lazy = false,
  version = false,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  keys = {
    { '<leader>?', ':Telescope oldfiles<cr>', desc = 'Find recently opened files' },
    { '<leader><space>', ':Telescope buffers<cr>', desc = 'Find existing buffers' },
    {
      '<leader>/',
      function()
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = 'Fuzzily search in current buffer',
    },
    { '<leader>sf', ':Telescope find_files<cr>', desc = 'Search Files' },
    { '<leader>sh', ':Telescope help_tags<cr>', desc = 'Search Help' },
    { '<leader>sw', ':Telescope grep_string<cr>', desc = 'Search Current Word' },
    { '<leader>sg', ':Telescope live_grep<cr>', desc = 'Search by Grep' },
    { '<leader>sd', ':Telescope diagnostics<cr>', desc = 'Search Diagnostics' },
    { '<leader>st', ':Telescope git_files<cr>', desc = 'Search Git Files' },
    { '<leader>sr', ':Telescope registers<cr>', desc = 'Search Registers' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        wrap_results = true,
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        },
      },
    }

    local telescope = require 'telescope'
    telescope.load_extension 'ui-select'
    telescope.load_extension 'fzf'
  end,
}
