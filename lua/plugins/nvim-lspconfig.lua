return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    {
      'mason-org/mason.nvim',
      config = true,
      cmd = 'Mason',
    },
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
  config = function()
    -- This is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', builtin.lsp_type_definitions, opts)
        vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gy', builtin.lsp_document_symbols, opts)
        vim.keymap.set('n', 'ws', builtin.lsp_dynamic_workspace_symbols, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end, opts)
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
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
    for _, pkg in pairs(packages) do
      if not registry.is_installed(pkg) then
        registry.get_package(pkg):install()
      end
    end

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
  end,
}
