vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/milanglacier/minuet-ai.nvim',
}

-- claude provider defaults to claude-haiku-5-5 and reads ANTHROPIC_API_KEY
require('minuet').setup { provider = 'claude' }
