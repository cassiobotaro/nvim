local api = vim.api

local augroup = api.nvim_create_augroup

-- don't auto comment new line
api.nvim_create_autocmd('FileType', {
  group = augroup('format-options', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- reopens the last cursor position
api.nvim_create_autocmd('BufReadPost', {
  group = augroup('restore-cursor', { clear = true }),
  callback = function()
    local pos = api.nvim_buf_get_mark(0, '"')
    local row, col = pos[1], pos[2]
    if row > 0 and row <= api.nvim_buf_line_count(0) then
      api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- remove trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
  group = augroup('trim-whitespace', { clear = true }),
  callback = function()
    if not vim.bo.modifiable or vim.bo.buftype ~= '' then
      return
    end
    local cursor = api.nvim_win_get_cursor(0)
    local lines = api.nvim_buf_get_lines(0, 0, -1, false)
    for i, line in ipairs(lines) do
      local trimmed = line:gsub('%s+$', '')
      if trimmed ~= line then
        api.nvim_buf_set_lines(0, i - 1, i, false, { trimmed })
      end
    end
    pcall(api.nvim_win_set_cursor, 0, cursor)
  end,
})

-- resize neovim split when terminal is resized
api.nvim_create_autocmd('VimResized', {
  group = augroup('auto-resize', { clear = true }),
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

-- Automatically open fzf-lua if not explicitly opening a file
api.nvim_create_autocmd('VimEnter', {
  group = augroup('fzf-startup', { clear = true }),
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require('fzf-lua').files()
      end)
    end
  end,
})
