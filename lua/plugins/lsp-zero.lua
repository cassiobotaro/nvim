-- lsp
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lua' },
    },
    config = function()
        local lsp = require('lsp-zero').preset {}

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps { buffer = bufnr }

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

        lsp.ensure_installed { 'bashls', 'lua_ls', 'rust_analyzer', 'gopls', 'pyright', 'taplo', 'dockerls', 'jsonls',
            'yamlls', 'bufls', 'ruff_lsp' }

        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
        require('lspconfig').yamlls.setup {
            settings = {
                yaml = {
                    schemas = { kubernetes = 'globPattern' },
                },
            },
        }

        lsp.setup()

        -- Make sure you setup `cmp` after lsp-zero

        local cmp = require 'cmp'
        local cmp_action = require('lsp-zero').cmp_action()

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup {
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'buffer',  keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
            },
            mapping = {
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
                -- Enable "Super TAB"
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
            },
        }

        vim.diagnostic.config {
            virtual_text = true,
        }

        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

        require('luasnip.loaders.from_vscode').lazy_load()
    end,
}
