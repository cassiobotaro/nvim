return {
  settings = {
    yaml = {
      -- disable the built-in schema store in favor of schemastore.nvim (more control, offline list)
      schemaStore = { enable = false, url = '' },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
