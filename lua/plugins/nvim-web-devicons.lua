-- modern icon provider; mock_nvim_web_devicons provides full API compatibility
return {
  'echasnovski/mini.icons',
  opts = {},
  config = function(_, opts)
    require('mini.icons').setup(opts)
    -- provide nvim-web-devicons compatibility for plugins that require it
    require('mini.icons').mock_nvim_web_devicons()
  end,
}
