return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        yaml = true,
      },
    },
    keys = {
      { '<leader>cd', ':Copilot disable<CR>', silent = true },
      { '<leader>ce', ':Copilot enable<CR>', silent = true },
    },
  },
}
