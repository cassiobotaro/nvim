vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = require 'gitsigns'
    local map = function(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    map('n', ']h', function() gs.nav_hunk 'next' end, 'Next hunk')
    map('n', '[h', function() gs.nav_hunk 'prev' end, 'Previous hunk')
    map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>gu', gs.undo_stage_hunk, 'Unstage hunk')
    map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>gb', gs.blame_line, 'Blame line')
    map('n', '<leader>gd', gs.diffthis, 'Diff this')
  end,
}
