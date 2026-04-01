if vim.g.copilot_enabled then
  require('copilot').setup {
    suggestion = {
      enabled = false,
    },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
      yaml = true,
    },
  }

  local map = vim.keymap.set
  map('n', '<leader>cd', ':Copilot disable<CR>', { silent = true })
  map('n', '<leader>ce', ':Copilot enable<CR>', { silent = true })
end
