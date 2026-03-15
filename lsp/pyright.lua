return {
  handlers = {
    -- Let ruff handle all diagnostics
    ['textDocument/publishDiagnostics'] = function() end,
  },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        typeCheckingMode = 'off',
        ignore = { '*' },
      },
    },
  },
}
