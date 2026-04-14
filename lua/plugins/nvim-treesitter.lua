-- tree-sitter is a parser generator tool and an incremental parsing library.
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

local ensure_installed = {
  'bash',
  'c',
  'diff',
  'dockerfile',
  'go',
  'gomod',
  'gosum',
  'gotmpl',
  'gowork',
  'html',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'regex',
  'terraform',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

local already_installed = require('nvim-treesitter.config').get_installed()
local parsers_to_install = vim.iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()
require('nvim-treesitter').install(parsers_to_install)
