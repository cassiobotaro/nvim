return {
  filetypes = { 'php', 'blade' },
  settings = {
    phpactor = {
      ['language_server_phpstan.enabled'] = false,
      ['language_server_psalm.enabled'] = false,
      ['php_extension_loader.extension_name'] = 'laravel',
    },
  },
}
