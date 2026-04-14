vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/folke/lazydev.nvim',
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
    local opts = { buffer = event.buf }

    local fzf = require 'fzf-lua'
    vim.keymap.set('n', 'gd', fzf.lsp_definitions, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'go', fzf.lsp_typedefs, opts)
    vim.keymap.set('n', 'grr', fzf.lsp_references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gy', fzf.lsp_document_symbols, opts)
    vim.keymap.set('n', 'gW', fzf.lsp_live_workspace_symbols, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
      require('conform').format { async = true, lsp_format = 'fallback' }
    end, opts)
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
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
