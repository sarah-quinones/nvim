local packer = require("packer")
local use = packer.use

-- using { } for using different branch , loading plugin with certain commands etc
return require("packer").startup(
    function()
        -- themes
        use "gruvbox-community/gruvbox"

        -- coc
        use { "neoclide/coc.nvim", branch = "release" }
        use "ervandew/supertab"

        -- navigation
        use "vim-scripts/matchit.zip"
        use "kshenoy/vim-signature"
        use "wellle/targets.vim"
        use "unblevable/quick-scope"
        use "easymotion/vim-easymotion"

        use "wbthomason/packer.nvim"
        use "tpope/vim-commentary"
        use "tpope/vim-surround"
        use "tpope/vim-repeat"

        -- syntax highlighting
        use "nvim-treesitter/nvim-treesitter"

        -- formatting
        use "sbdchd/neoformat"

        use "lewis6991/gitsigns.nvim"
        use "akinsho/nvim-bufferline.lua"
        use "windwp/nvim-autopairs"

        -- file managing , picker etc
        use "kyazdani42/nvim-web-devicons"
        use "glepnir/galaxyline.nvim"
        use "nvim-telescope/telescope.nvim"
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "pbrisbin/vim-mkdir"
        use "lambdalisue/suda.vim"
        use "tpope/vim-eunuch"

        -- misc
        use "tweekmonster/startuptime.vim"
        use "blueyed/vim-diminactive"

    end,
    {
        display = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
        }
    }
)
