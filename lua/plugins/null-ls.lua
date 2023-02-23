return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    { 'jay-babu/mason-null-ls.nvim' },
    { 'williamboman/mason.nvim' },
  },
  config = function()
    local nls = require 'null-ls'
    require('mason-null-ls').setup {
      ensure_installed = {
        'stylua',
        'black',
        'prettier',
        'shfmt',
        'goimports',
        'rustfmt',
        'shfmt',
        'yamllint',
        'protolint',
      },
    }

    -- configuring null-ls for formatters
    local formatting = nls.builtins.formatting
    local diagnostics = nls.builtins.diagnostics
    local actions = nls.builtins.code_actions

    nls.setup {
      sources = {
        formatting.prettier.with {
          filetypes = { 'json', 'markdown', 'toml' },
        },
        formatting.shfmt,
        formatting.stylua.with {
          condition = function(utils)
            return utils.root_has_file { 'stylua.toml', '.stylua.toml' }
          end,
        },
        formatting.goimports,
        formatting.black,
        diagnostics.yamllint.with {
          extra_args = { '-d', '{extends: relaxed, rules: {line-length: {max: 200}}}' },
        },
        diagnostics.shellcheck,
        actions.shellcheck,
        formatting.protolint,
        diagnostics.protolint,
      },
    }
  end,
}
