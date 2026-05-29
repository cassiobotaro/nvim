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

-- the main branch only installs parsers; highlight and indent must be started
-- per buffer (the bundled ftplugins only do this for lua/markdown/help/query)
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and pcall(vim.treesitter.language.add, lang) then
      vim.treesitter.start(args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
