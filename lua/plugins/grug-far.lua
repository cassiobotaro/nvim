-- project wide search and replace in an editable buffer, powered by ripgrep;
-- inside the buffer <localleader>r applies the replacement
-- setup() is optional and the plugin defers its own requires, so it stays lazy
vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }

vim.keymap.set('n', '<leader>R', '<cmd>GrugFar<cr>', { desc = 'Search and replace in project' })
-- ':' (instead of '<cmd>') so the visual range reaches the command and prefills the search
vim.keymap.set('x', '<leader>R', ':GrugFar<cr>', { desc = 'Search and replace selection in project' })
