vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]]) -- move lines up respecting identation
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]]) -- move lines down respecting identation
vim.keymap.set('n', 'J', [[mzJ`z]]) -- join lines without move cursor
vim.keymap.set('n', '<C-d>', [[<C-d>zz]]) -- scroll window Downwards in the buffer.
vim.keymap.set('n', '<C-u>', [[<C-u>zz]]) -- scroll window Upwards in the buffer.
vim.keymap.set('n', 'n', [[nzzzv]]) -- search will center on the line it's found in
vim.keymap.set('n', 'N', [[Nzzzv]]) -- search will center on the line it's found in
vim.keymap.set('n', '<C-k>', [[<cmd>cnext<CR>zz]]) -- navigate next in quickfix list
vim.keymap.set('n', '<C-j>', [[<cmd>cprev<CR>zz]]) -- navigate previous in quickfix list
vim.keymap.set('n', '<leader>k', [[<cmd>lnext<CR>zz]]) -- navigate next in location list
vim.keymap.set('n', '<leader>j', [[<cmd>lprev<CR>zz]]) -- navigate previous in location list
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search and replace
vim.keymap.set('n', '<leader>x', [[<cmd>!chmod +x %<CR>]], { silent = true }) -- allow execution permission
vim.keymap.set('n', '<leader>h', vim.cmd.split) -- split horizontally
vim.keymap.set('n', '<leader>v', vim.cmd.vsplit) -- split vertically
vim.keymap.set('n', '<leader>q', vim.cmd.bp) -- move to previous buffer
vim.keymap.set('n', '<leader>w', vim.cmd.bn) -- move to next buffer
vim.keymap.set('n', '<leader>c', vim.cmd.bd) -- close current buffer
vim.keymap.set('n', '<leader>.', [[<Cmd>lcd %:p:h<CR>]]) -- set current file directory as working directory
vim.keymap.set('v', '<', [[<gv]]) -- move code forward in visual mode
vim.keymap.set('v', '>', [[>gv]]) -- move code backward in visual mode
