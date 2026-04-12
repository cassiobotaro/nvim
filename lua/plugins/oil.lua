vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup()

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Toggle file explorer' })
