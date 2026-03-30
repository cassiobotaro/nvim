-- tree-sitter is a parser generator tool and an incremental parsing library.
-- Requires Neovim 0.12+ and tree-sitter-cli >= 0.26.1
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false, -- main branch does not support lazy-loading
  build = ':TSUpdate',
  dependencies = { { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' } },
  config = function()
    local parsers = {
      'bash',
      'c',
      'diff',
      'dockerfile',
      'go',
      'gomod',
      'gosum',
      'gotmpl',
      'gowork',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'terraform',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    }

    require('nvim-treesitter').install(parsers)

    -- Enable treesitter highlighting (built-in Neovim feature, managed via nvim-treesitter queries)
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Enable treesitter highlighting',
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- Textobjects: select, move, and swap — uses new nvim-treesitter-textobjects main API
    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = true,
        keymaps = {
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        swap_next = { ['<leader>a'] = '@parameter.inner' },
        swap_previous = { ['<leader>A'] = '@parameter.inner' },
      },
    }
  end,
}
