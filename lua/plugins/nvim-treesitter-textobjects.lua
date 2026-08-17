-- syntax aware text objects: select, move and swap functions/classes/parameters
-- the main branch is required to match nvim-treesitter's main branch
vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' } }

require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true }, -- jump forward to the textobject, like targets.vim
  move = { set_jumps = true },
}

local select = require 'nvim-treesitter-textobjects.select'
local move = require 'nvim-treesitter-textobjects.move'
local swap = require 'nvim-treesitter-textobjects.swap'

for key, query in pairs {
  af = '@function.outer',
  ['if'] = '@function.inner',
  ac = '@class.outer',
  ic = '@class.inner',
  aa = '@parameter.outer',
  ia = '@parameter.inner',
} do
  vim.keymap.set({ 'x', 'o' }, key, function()
    select.select_textobject(query, 'textobjects')
  end, { desc = 'Select ' .. query:sub(2) })
end

-- ]m/[m and ]]/[[ are already taken by the built-in go and python ftplugins,
-- whose buffer-local maps would win over these
vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
  move.goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
  move.goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
  move.goto_next_end('@function.outer', 'textobjects')
end, { desc = 'Next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
  move.goto_previous_end('@function.outer', 'textobjects')
end, { desc = 'Previous function end' })

vim.keymap.set('n', '<leader>a', function()
  swap.swap_next '@parameter.inner'
end, { desc = 'Swap parameter with next' })
vim.keymap.set('n', '<leader>A', function()
  swap.swap_previous '@parameter.inner'
end, { desc = 'Swap parameter with previous' })
