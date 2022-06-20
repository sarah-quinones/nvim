-- python setup
vim.g.python3_host_prog = vim.env.HOME .. "/miniconda3/bin/python"
vim.api.nvim_set_option("pyxversion", 3)

vim.g.neovide_guifont = "FiraCode Nerd Font"
vim.g.neovide_fontsize = 10
vim.api.nvim_set_option("guifont", vim.g.neovide_guifont .. ":h" .. vim.g.neovide_fontsize)

-- shell integration (i think?)
if vim.env.ZDOTDIR == nil or vim.env.LOCAL_HOME == nil then
  vim.env.ZDOTDIR = vim.env.HOME .. "/.local/share/zsh"
  vim.env.LOCAL_HOME = vim.env.HOME
end

vim.env.VIMCONFIG = vim.env.LOCAL_HOME .. "/.config/nvim/"

require "misc-utils"
vim.cmd "syntax on"
-- load all plugins
require "pluginList"
require "file-icons"

require "statusline"

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- colorscheme
vim.cmd([[colorscheme gruvbox]])
vim.o.background = "dark"

-- coc.nvim
vim.g.coc_global_extensions = {"coc-vimlsp", "coc-pyright", "coc-snippets", "coc-rust-analyzer", "coc-clangd"}

-- quick scope
vim.g.qs_highlight_on_keys = {"f", "F", "t", "T"}

-- targets.vim
vim.g.targets_seekRanges = "cc cr cb cB lc ac Ac lr lb ar ab lB Ar"
  .. "aB Ab AB rr ll rb al rB Al bb aa bB Aa BB AA"


require "treesitter-nvim"
require "mappings"

require "telescope-nvim"

-- git signs
require "gitsigns-nvim"

-- auto pairs
require("nvim-autopairs").setup()

vim.cmd([[
  augroup window_focus_relnum
    autocmd!
    autocmd FocusLost   * setlocal norelativenumber
    autocmd FocusGained * setlocal   relativenumber
  augroup end
]])

-- highlight matches in search->cedit
local cmd = "autocmd TextChanged,TextChangedI,TextChangedP " ..
            "<buffer> let @/ = getline('.')"
vim.cmd([[
  augroup cmd_win_highlight
    autocmd!
    autocmd CmdwinEnter /,? let @/ = getline('.') | ]] .. cmd .. "\naugroup end"
)

require "buffers"
require "terminal"
