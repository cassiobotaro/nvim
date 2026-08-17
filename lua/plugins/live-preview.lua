-- browser live preview for markdown/html/asciidoc/svg; pure lua, no build step
-- :LivePreview start | close | pick
vim.pack.add { 'https://github.com/brianhuster/live-preview.nvim' }

require('livepreview.config').set {
  picker = 'fzf-lua',
}
