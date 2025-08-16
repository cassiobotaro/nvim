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
    -- installing linters/lsp/formatters
    local packages = {
      'bash-language-server',
      'dockerfile-language-server',
      'goimports',
      'gopls',
      'json-lsp',
      'lua-language-server',
      'pyright',
      'ruff',
      'shellcheck',
      'shfmt',
      'stylua',
      'yaml-language-server',
    }
    local registry = require 'mason-registry'
    for _, pkg in pairs(packages) do
      if not registry.is_installed(pkg) then
        registry.get_package(pkg):install()
      end
    end

    -- This is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', builtin.lsp_type_definitions, opts)
        vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set('n', 'gy', builtin.lsp_document_symbols, opts)
        vim.keymap.set('n', 'ws', builtin.lsp_dynamic_workspace_symbols, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
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

    vim.lsp.enable {
      'bashls',
      'dockerls',
      'gopls',
      'jsonls',
      'lua_ls',
      'pyright',
      'ruff',
      'yamlls',
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
