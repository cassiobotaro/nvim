return {
  -- Package manager
  'wbthomason/packer.nvim',

  -- fancy icons
  'nvim-tree/nvim-web-devicons',

  -- colorscheme
  'navarasu/onedark.nvim',

  -- buffer tabs
  { 'akinsho/bufferline.nvim', version = 'v3.*', dependencies = 'nvim-tree/nvim-web-devicons' },

  -- comment stuff out
  'numToStr/Comment.nvim',

  -- surround selections, stylishly
  'kylechui/nvim-surround',

  -- git
  { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
  'lewis6991/gitsigns.nvim',

  -- highly extendable fuzzy finder over lists
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- tree-sitter is a parser generator tool and an incremental parsing library.
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' } },

  -- lsp
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  },
  'jose-elias-alvarez/null-ls.nvim',
  'j-hui/fidget.nvim',
}
