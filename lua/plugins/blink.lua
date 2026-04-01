require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  cmdline = { enabled = false },
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
    providers = {
      copilot = {
        name = 'copilot',
        module = 'blink-copilot',
        score_offset = 100,
        async = true,
      },
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- higher priority than copilot for Neovim API completions
        score_offset = 150,
      },
    },
  },
  fuzzy = { implementation = 'prefer_rust' },
}
