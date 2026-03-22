return {
  -- attach to all yaml compound filetypes so LSP works in specialized files
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  settings = {
    yaml = {},
  },
}
