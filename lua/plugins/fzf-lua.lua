-- fast fuzzy finder using the fzf binary (requires fzf installed on the system)
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  config = function()
    local fzf = require 'fzf-lua'
    fzf.register_ui_select()
  end,
  keys = {
    { '<leader>?', function() require('fzf-lua').oldfiles() end, desc = 'Find recently opened files' },
    { '<leader><space>', function() require('fzf-lua').buffers() end, desc = 'Find existing buffers' },
    { '<leader>/', function() require('fzf-lua').lgrep_curbuf() end, desc = 'Fuzzily search in current buffer' },
    { '<leader>sf', function() require('fzf-lua').files() end, desc = 'Search Files' },
    { '<leader>sh', function() require('fzf-lua').help_tags() end, desc = 'Search Help' },
    { '<leader>sw', function() require('fzf-lua').grep_cword() end, desc = 'Search Current Word' },
    { '<leader>sg', function() require('fzf-lua').live_grep() end, desc = 'Search by Grep' },
    { '<leader>sd', function() require('fzf-lua').diagnostics_workspace() end, desc = 'Search Diagnostics' },
    { '<leader>st', function() require('fzf-lua').git_files() end, desc = 'Search Git Files' },
    { '<leader>sr', function() require('fzf-lua').registers() end, desc = 'Search Registers' },
  },
}
