vim.pack.add {
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1' },
}

require('blink.cmp').setup {
  cmdline = { enabled = false },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- prioritize Neovim API completions over LSP
        score_offset = 150,
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust' },
}
