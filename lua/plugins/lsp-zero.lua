-- lsp
return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      dependencies = {
        { 'rafamadriz/friendly-snippets' },
      },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lua' },
    {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup {
          library = { plugins = { 'neotest', 'plenary.nvim' }, types = true, setup_jsonls = false },
        }
      end,
    },
  },
  config = function()
    local lsp_zero = require 'lsp-zero'
    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps { buffer = bufnr }

      -- custom keybindings
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end
      map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
      map('gr', require('telescope.builtin').lsp_references, 'Goto References')
      map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions')
      map('gI', vim.lsp.buf.implementation, 'Goto Implementation')
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definitions')
      map('ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
      map('ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
          vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
          vim.lsp.buf.formatting()
        end
      end, { desc = 'Format current buffer with LSP' })

      -- format on save if supported
      if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { bufnr = bufnr }
          end,
        })
      end
    end)
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
        'bufls',
        'ruff_lsp',
      },
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
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

    local cmp = require 'cmp'
    local cmp_format = lsp_zero.cmp_format()
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup {
      formatting = cmp_format,
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        -- scroll up and down the documentation window
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
      },
    }

    vim.diagnostic.config {
      virtual_text = true,
    }
  end,
}
