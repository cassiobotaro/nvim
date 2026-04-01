local gh = function(x)
  return 'https://github.com/' .. x
end

-- Run build for CopilotChat after install/update
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'CopilotChat.nvim' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.system({ 'make', 'tiktoken' }, { cwd = ev.data.path }, function(obj)
        if obj.code ~= 0 then
          local msg = string.format('CopilotChat.nvim: "make tiktoken" failed with exit code %d', obj.code or -1)
          if obj.stderr and #obj.stderr > 0 then
            msg = msg .. (': ' .. obj.stderr)
          end
          vim.schedule(function()
            vim.notify(msg, vim.log.levels.ERROR)
          end)
        end
      end)
    end
  end,
})

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Update all plugins' })

vim.pack.add {
  -- icons
  gh 'echasnovski/mini.icons',
  -- colorscheme
  gh 'navarasu/onedark.nvim',
  -- status line
  gh 'nvim-lualine/lualine.nvim',
  -- buffer tabs
  gh 'akinsho/bufferline.nvim',
  -- file explorer
  gh 'stevearc/oil.nvim',
  -- git
  gh 'lewis6991/gitsigns.nvim',
  gh 'NeogitOrg/neogit',
  { src = gh 'nvim-lua/plenary.nvim', version = 'master' },
  -- fuzzy finder
  gh 'ibhagwan/fzf-lua',
  -- treesitter
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  -- lsp
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'folke/lazydev.nvim',
  -- completion
  { src = gh 'saghen/blink.cmp', version = vim.version.range('^1.0.0') },
  gh 'rafamadriz/friendly-snippets',
  gh 'fang2hou/blink-copilot',
  -- formatting
  gh 'stevearc/conform.nvim',
  -- UI
  gh 'folke/noice.nvim',
  gh 'MunifTanjim/nui.nvim',
  gh 'rcarriga/nvim-notify',
  gh 'j-hui/fidget.nvim',
  -- editing
  gh 'kylechui/nvim-surround',
  -- terminal
  gh 'akinsho/toggleterm.nvim',
  -- markdown
  gh 'MeanderingProgrammer/render-markdown.nvim',
  -- copilot
  gh 'zbirenbaum/copilot.lua',
  { src = gh 'CopilotC-Nvim/CopilotChat.nvim', version = 'main' },
}

require 'plugins.nvim-web-devicons'
require 'plugins.onedark'
require 'plugins.lualine'
require 'plugins.bufferline'
require 'plugins.oil'
require 'plugins.gitsigns'
require 'plugins.neogit'
require 'plugins.fzf-lua'
require 'plugins.nvim-treesitter'
require 'plugins.nvim-lspconfig'
require 'plugins.blink'
require 'plugins.conform'
require 'plugins.noice'
require 'plugins.fidget'
require 'plugins.nvim-surround'
require 'plugins.toggleterm'
require 'plugins.render-markdown'
require 'plugins.copilot'
require 'plugins.copilot-chat'
