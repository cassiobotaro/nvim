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
  callback = function(args)
    local row, col = (table.unpack or unpack)(api.nvim_buf_get_mark(args.buf, '"'))
    if row > 0 and row <= api.nvim_buf_line_count(args.buf) then
      api.nvim_win_set_cursor(0, { row, col })
    end
  end,
})

-- remove trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
  callback = function(args)
    if not vim.bo[args.buf].modifiable or vim.bo[args.buf].buftype ~= '' then
      return
    end
    local cursor = api.nvim_win_get_cursor(0)
    local lines = api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local changed = false
    for i, line in ipairs(lines) do
      local stripped = line:gsub('%s+$', '')
      if stripped ~= line then
        lines[i] = stripped
        changed = true
      end
    end
    if changed then
      api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
    end
    api.nvim_win_set_cursor(0, cursor)
  end,
})

-- highlight on yank
api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- resize neovim split when terminal is resized
api.nvim_create_autocmd('VimResized', {
  callback = function()
    vim.cmd.wincmd '='
  end,
})

-- update all plugins
api.nvim_create_user_command('PackUpdate', function()
  vim.notify('Checking for plugin updates…', vim.log.levels.INFO)
  vim.pack.update()
end, { desc = 'Update all plugins' })

-- Automatically open fzf-lua if not explicitly opening a file
api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require('fzf-lua').files()
      end)
    end
  end,
})
