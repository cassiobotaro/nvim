local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- reopens the last cursor position
api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local row, col = unpack(api.nvim_buf_get_mark(0, '"'))
    if row > 0 and row <= api.nvim_buf_line_count(0) then
      api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- remove trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if not vim.bo.modifiable or vim.bo.buftype ~= '' then
      return
    end
    vim.cmd ':%s/\\s\\+$//e'
  end,
})

-- highlight on yank
api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize neovim split when terminal is resized
api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

-- Automatically open telescope if not explicitly opening a file
api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require('telescope.builtin').find_files()
      end)
    end
  end,
})
