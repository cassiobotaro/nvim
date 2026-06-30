-- buffer tabs (tabline); uses mini.icons for file icons
vim.pack.add { 'https://github.com/echasnovski/mini.tabline' }

require('mini.tabline').setup()

-- make the current buffer tab stand out from visible/hidden ones
local function highlight_current()
  local colors = require('onedark.palette').darker
  -- current buffer: accent background + bold so it's obvious which tab is active
  vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { fg = colors.bg0, bg = colors.blue, bold = true })
  vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { fg = colors.bg0, bg = colors.yellow, bold = true })
  -- visible (shown in another window) and hidden buffers stay muted
  vim.api.nvim_set_hl(0, 'MiniTablineVisible', { fg = colors.fg, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, 'MiniTablineModifiedVisible', { fg = colors.yellow, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, 'MiniTablineHidden', { fg = colors.grey, bg = colors.bg0 })
  vim.api.nvim_set_hl(0, 'MiniTablineModifiedHidden', { fg = colors.grey, bg = colors.bg0 })
end

highlight_current()

-- re-apply after any colorscheme change so the override survives
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = highlight_current,
})
