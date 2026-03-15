return {
  'stevearc/conform.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format', 'ruff_organize_imports', 'ruff_fix' },
        go = { 'goimports' },
        bash = { 'shfmt' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
      },
    }
  end,
}
