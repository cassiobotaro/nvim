require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = require 'gitsigns'
    local map = function(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    map('n', ']h', gs.next_hunk, 'Next hunk')
    map('n', '[h', gs.prev_hunk, 'Previous hunk')
    map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
    map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>gb', gs.blame_line, 'Blame line')
    map('n', '<leader>gd', gs.diffthis, 'Diff this')
  end,
}
