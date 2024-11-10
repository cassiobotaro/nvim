return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- LSP Support
    { 'williamboman/mason.nvim',          config = true, cmd = 'Mason' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- formatting
    { "stevearc/conform.nvim" },
  },
  config = function()
    local tools = {
      'shfmt',
      'shellcheck',
      'yamllint',
      'bash-language-server',
      'stylua',
      'prettier',
      'shfmt',
      'goimports',
      'ruff',
    }
    for _, f in pairs(tools) do
      local pkg = require('mason-registry').get_package(f)
      if not pkg:is_installed(f) then
        pkg:install(f)
      end
    end

    -- default capabilities
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend('force', lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities())

    -- keymaps
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
      end,
    })

    require("conform").setup({
      formatters_by_ft = {
        json = { "prettier" },
        markdown = { "prettier" },
        toml = { "prettier" },
        lua = { "stylua" },
        yaml = { "yamllint" },
        sh = { "shfmt", "shellcheck" },
        go = { "goimports" },
        python = { "ruff" },
      },
    })
    require("conform").setup({
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })


    -- format on save
    local buffer_autoformat = function(bufnr)
      local group = 'lsp_autoformat'
      vim.api.nvim_create_augroup(group, { clear = false })
      vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }

      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = group,
        desc = 'LSP format on save',
        callback = function()
          -- note: do not enable async formatting
          vim.lsp.buf.format { async = false, timeout_ms = 10000 }
        end,
      })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil then
          return
        end

        -- make sure there is at least one client with formatting capabilities
        if client.supports_method 'textDocument/formatting' then
          buffer_autoformat(event.buf)
        end
      end,
    })

    -- mason settings
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
      ensure_installed = {
        'bashls',
        'lua_ls',
        'gopls',
        'taplo',
        'dockerls',
        'jsonls',
        'yamlls',
        'ruff',
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {}
        end,
        yamlls = function()
          require('lspconfig').yamlls.setup {
            settings = {
              yaml = {
                schemas = { kubernetes = 'globPattern' },
              },
            },
          }
        end,
      },
    }

    -- cmp settings
    local cmp = require 'cmp'
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

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
        -- Navigate between snippets
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },
    }
  end,
}
