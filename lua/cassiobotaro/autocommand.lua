local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

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
    vim.cmd ':%s/\\s\\+$//e'
  end,
})

-- highlight on yank
api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize neovim split when terminal is resized
api.nvim_command 'autocmd VimResized * wincmd ='
