return {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    local nls = require 'null-ls'
    local mason_registry = require 'mason-registry'

    local tools = {
      'stylua',
      'black',
      'prettier',
      'shfmt',
      'goimports',
      'rustfmt',
      'shfmt',
      'yamllint',
      'protolint',
    }

    -- install tools
    for _, f in pairs(tools) do
      local pkg = mason_registry.get_package(f)
      if not pkg:is_installed(f) then
        pkg:install(f)
      end
    end

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
          extra_args = function(_)
            local base_cfg = vim.fn.stdpath 'config' .. '/.stylua.toml'
            local cfg = vim.fs.find('.stylua.toml', { upward = true })
            if #cfg == 0 then
              ---@diagnostic disable-next-line: cast-local-type
              cfg = base_cfg
            else
              cfg = cfg[1]
            end
            return { '--config-path', cfg }
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
