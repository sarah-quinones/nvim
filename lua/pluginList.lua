vim.cmd([[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'ervandew/supertab'
Plug 'vim-scripts/matchit.zip'
Plug 'kshenoy/vim-signature'
Plug 'wellle/targets.vim'

Plug 'ggandor/lightspeed.nvim'

Plug 'wbthomason/packer.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'sbdchd/neoformat'

Plug 'lewis6991/gitsigns.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'windwp/nvim-autopairs'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'glepnir/galaxyline.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'pbrisbin/vim-mkdir'
Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-eunuch'
Plug 'simeji/winresizer'

Plug 'tweekmonster/startuptime.vim'
Plug 'sainnhe/edge'
Plug 'projekt0n/github-nvim-theme'
Plug 'olimorris/onedarkpro.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

call plug#end()
]])
