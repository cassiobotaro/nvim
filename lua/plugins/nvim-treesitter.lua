-- tree-sitter is a parser generator tool and an incremental parsing library.
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    require('nvim-treesitter.configs').setup {

      ensure_installed = {
        'bash',
        'c',
        'diff',
        'dockerfile',
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'gowork',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'terraform',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
      },

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<c-m>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
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
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
  end,
}
