vim.pack.add {
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
}

require('blink.cmp').setup {
  cmdline = { enabled = false },
  completion = {
    documentation = { auto_show = true },
    -- avoid firing an LLM request on every InsertEnter
    trigger = { prefetch_on_insert = false },
  },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'minuet' },
    providers = {
      minuet = {
        name = 'minuet',
        module = 'minuet.blink',
        async = true,
        -- matches minuet's request_timeout (3s)
        timeout_ms = 3000,
        score_offset = 100,
      },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- higher priority than minuet for Neovim API completions
        score_offset = 150,
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust' },
}
