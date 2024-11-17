return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true, cmd = 'Mason' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lua' },
  },
  config = function()
    -- installing tools
    local tools = {
      'shfmt',
      'stylua',
      'goimports',
      'prettier',
      'shellcheck',
      'yamllint',
    }
    for _, f in pairs(tools) do
      local pkg = require('mason-registry').get_package(f)
      if not pkg:is_installed(f) then
        pkg:install(f)
      end
    end

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend('force', lspconfig_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

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
        vim.keymap.set('n', 'ds', builtin.lsp_document_symbols, opts)
        vim.keymap.set('n', 'ws', builtin.lsp_dynamic_workspace_symbols, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
      end,
    })

    local servers = {
      bashls = {},
      taplo = {},
      dockerls = {},
      jsonls = {},
      yamlls = {
        settings = {
          yaml = {
            schemas = { kubernetes = 'globPattern' },
          },
        },
      },
      lua_ls = {},
      ruff = {},
      pyright = {
        settings = {
          pyright = {
            -- use ruff-lsp for organizing imports
            disableOrganizeImports = true,
            typeCheckingMode = 'off',
          },
          python = {
            -- use ruff-lsp for analysis
            analysis = { ignore = '*' },
          },
        },
      },
      gopls = {},
    }

    require('mason').setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_uninstalled = '✗',
          package_pending = '⟳',
        },
      },
    }
    require('mason-lspconfig').setup {
      ensure_installed = vim.tbl_keys(servers),
      handlers = {
        function(server_name)
          local server_opts = servers[server_name]
          server_opts.capabilities = lspconfig_defaults.capabilities
          require('lspconfig')[server_name].setup {
            settings = server_opts.settings,
            capabilities = server_opts.capabilities,
          }
        end,
      },
    }

    ---
    -- Autocompletion config
    ---
    local cmp = require 'cmp'

    cmp.setup {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
      },
      mapping = cmp.mapping.preset.insert {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm { select = false },

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
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
