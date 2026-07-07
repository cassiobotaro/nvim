return {
  -- attach to all yaml compound filetypes so LSP works in specialized files
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  settings = {
    yaml = {
      -- disable the built-in schema store in favor of schemastore.nvim (more control, offline list)
      schemaStore = { enable = false, url = '' },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
