-- comment stuff out
return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
    local ft = require 'Comment.ft'
    -- Add filetype specific comment strings
    ft.set('structurizr', { '//%s', '/*%s*/' })
  end,
}
