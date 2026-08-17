-- autopairs for brackets and quotes; also takes over <BS> and <CR> so deleting
-- and splitting a pair works (both are free, blink.cmp accepts with <C-y>)
vim.pack.add { 'https://github.com/echasnovski/mini.pairs' }

require('mini.pairs').setup()
