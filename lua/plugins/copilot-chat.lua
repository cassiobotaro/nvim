if vim.g.copilot_enabled then
  require('CopilotChat').setup {
    window = {
      layout = 'float',
    },
  }

  local map = vim.keymap.set
  map('n', '<leader>ccq', function()
    local input = vim.fn.input 'Quick Chat: '
    if input ~= '' then
      require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
    end
  end, { desc = 'CopilotChat - Quick chat' })
  map('n', '<leader>cce', '<cmd>CopilotChatExplain<cr>', { desc = 'CopilotChat - Explain code' })
  map('n', '<leader>cct', '<cmd>CopilotChatTests<cr>', { desc = 'CopilotChat - Generate tests' })
  map('n', '<leader>ccf', '<cmd>CopilotChatFix<cr>', { desc = 'CopilotChat - Fix code' })
  map('n', '<leader>ccc', '<cmd>CopilotChatCommit<cr>', { desc = 'CopilotChat - Commit code' })
  map('n', '<leader>ccr', '<cmd>CopilotChatReview<cr>', { desc = 'CopilotChat - Review code' })
  map('n', '<leader>cch', '<cmd>CopilotChat<cr>', { desc = 'CopilotChat - Chat' })
end
