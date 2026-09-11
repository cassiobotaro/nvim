-- tree-sitter is a parser generator tool and an incremental parsing library.
vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

-- parsers neovim already ships (c, lua, markdown, markdown_inline, query, vim,
-- vimdoc) are left out: they are reported as installed and never downloaded
local ensure_installed = {
  'bash',
  'css',
  'diff',
  'dockerfile',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'make',
  'python',
  'regex',
  'toml',
  'tsx',
  'typescript',
  'yaml',
}

local already_installed = require('nvim-treesitter.config').get_installed()
local parsers_to_install = vim
  .iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(already_installed, parser)
  end)
  :totable()
require('nvim-treesitter').install(parsers_to_install)

-- :PackUpdate bumps the parser revisions pinned by the plugin (and its
-- queries) but leaves the compiled parsers on disk untouched; keep them in sync
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('treesitter-update-parsers', { clear = true }),
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      require('nvim-treesitter').update()
    end
  end,
})

-- nvim maps tsconfig.json/.eslintrc/.babelrc & friends to the jsonc filetype,
-- for which no parser exists on the main branch -- reuse the json one
vim.treesitter.language.register('json', 'jsonc')

-- the main branch only installs parsers; highlight and indent must be started
-- per buffer (the bundled ftplugins only do this for lua/markdown/help/query)
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then
      return
    end
    -- language.add returns false (without erroring) when no parser exists, so
    -- the pcall guard alone is not enough — check its return value too
    local ok, loaded = pcall(vim.treesitter.language.add, lang)
    if ok and loaded then
      vim.treesitter.start(args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
