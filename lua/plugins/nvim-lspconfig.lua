vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/b0o/schemastore.nvim', -- JSON/YAML schemas from SchemaStore for jsonls/yamlls
}

require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local function map(keys, fn, desc)
      vim.keymap.set('n', keys, fn, { buffer = event.buf, desc = desc })
    end

    local fzf = require 'fzf-lua'
    map('gd', fzf.lsp_definitions, 'Go to definition')
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    map('go', fzf.lsp_typedefs, 'Go to type definition')
    map('grr', fzf.lsp_references, 'List references')
    map('gri', fzf.lsp_implementations, 'Go to implementation')
    vim.keymap.set({ 'n', 'x' }, 'gra', fzf.lsp_code_actions, { buffer = event.buf, desc = 'Code action' })
    map('gs', vim.lsp.buf.signature_help, 'Signature help')
    map('gy', fzf.lsp_document_symbols, 'Document symbols')
    map('gW', fzf.lsp_live_workspace_symbols, 'Workspace symbols')
    map('gl', vim.diagnostic.open_float, 'Show line diagnostics')
    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
      require('conform').format { async = true, lsp_format = 'fallback' }
    end, { buffer = event.buf, desc = 'Format buffer' })
  end,
})

require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_uninstalled = '✗',
      package_pending = '⟳',
    },
  },
}

-- installing linters/lsp/formatters
local packages = {
  'bash-language-server',
  'dockerfile-language-server',
  'goimports',
  'gopls',
  'json-lsp',
  'lua-language-server',
  'prettier',
  'pyright',
  'ruff',
  'shellcheck',
  'shfmt',
  'stylua',
  'yaml-language-server',
  'typescript-language-server',
}
local registry = require 'mason-registry'
vim.schedule(function()
  registry.refresh(function()
    for _, pkg in pairs(packages) do
      if not registry.is_installed(pkg) then
        local ok, p = pcall(registry.get_package, pkg)
        if ok then p:install() end
      end
    end
  end)
end)

vim.lsp.enable {
  'bashls',
  'dockerls',
  'gopls',
  'jsonls',
  'lua_ls',
  'pyright',
  'ruff',
  'yamlls',
  'ts_ls',
}

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
}
