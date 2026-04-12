-- modern icon provider; mock_nvim_web_devicons provides full API compatibility
vim.pack.add { 'https://github.com/echasnovski/mini.icons' }

require('mini.icons').setup()
-- provide nvim-web-devicons compatibility for plugins that require it
require('mini.icons').mock_nvim_web_devicons()
