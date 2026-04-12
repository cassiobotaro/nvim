-- fast fuzzy finder using the fzf binary (requires fzf installed on the system)
vim.pack.add {
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/ibhagwan/fzf-lua',
}

local fzf = require 'fzf-lua'
fzf.register_ui_select()

vim.keymap.set('n', '<leader>?', fzf.oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = 'Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = 'Search Current Word' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_workspace, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>st', fzf.git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>sr', fzf.registers, { desc = 'Search Registers' })
