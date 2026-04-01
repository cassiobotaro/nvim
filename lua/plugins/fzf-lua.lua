-- fast fuzzy finder using the fzf binary (requires fzf installed on the system)
local fzf = require 'fzf-lua'
fzf.register_ui_select()

local map = vim.keymap.set
map('n', '<leader>?', function() fzf.oldfiles() end, { desc = 'Find recently opened files' })
map('n', '<leader><space>', function() fzf.buffers() end, { desc = 'Find existing buffers' })
map('n', '<leader>/', function() fzf.lgrep_curbuf() end, { desc = 'Fuzzily search in current buffer' })
map('n', '<leader>sf', function() fzf.files() end, { desc = 'Search Files' })
map('n', '<leader>sh', function() fzf.help_tags() end, { desc = 'Search Help' })
map('n', '<leader>sw', function() fzf.grep_cword() end, { desc = 'Search Current Word' })
map('n', '<leader>sg', function() fzf.live_grep() end, { desc = 'Search by Grep' })
map('n', '<leader>sd', function() fzf.diagnostics_workspace() end, { desc = 'Search Diagnostics' })
map('n', '<leader>st', function() fzf.git_files() end, { desc = 'Search Git Files' })
map('n', '<leader>sr', function() fzf.registers() end, { desc = 'Search Registers' })
