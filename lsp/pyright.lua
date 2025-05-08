return {
  settings = {
    pyright = {
      -- use ruff-lsp for organizing imports
      disableOrganizeImports = true,
      typeCheckingMode = 'off',
      -- disable pyright's built-in analysis
    },
    python = {
      -- use ruff-lsp for analysis
      analysis = { diagnosticMode = 'off', ignore = '*' },
    },
  },
}
