return {
  'CopilotC-Nvim/CopilotChat.nvim',
  build = 'make tiktoken',
  dependencies = {
    { 'zbirenbaum/copilot.lua' },
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  branch = 'main',
  config = true,
  enabled = vim.g.copilot_enabled,
  event = 'VeryLazy',
  opts = {
    window = {
      layout = 'float',
    },
  },
  keys = {
    {
      '<leader>ccq',
      function()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
        end
      end,
      desc = 'CopilotChat - Quick chat',
    },
    { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
    { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
    { '<leader>ccf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix code' },
    { '<leader>ccc', '<cmd>CopilotChatCommit<cr>', desc = 'CopilotChat - Commit code' },
    { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
    { '<leader>cch', '<cmd>CopilotChat<cr>', desc = 'CopilotChat - Chat' },
  },
}
