-- python setup
vim.g.python3_host_prog = vim.env.HOME .. "/miniconda3/bin/python"
vim.api.nvim_set_option("pyxversion", 3)

vim.g.neovide_guifont = "FiraCode Nerd Font"
vim.g.neovide_fontsize = 10
vim.api.nvim_set_option("guifont", vim.g.neovide_guifont .. ":h" .. vim.g.neovide_fontsize)
vim.api.nvim_set_option("wrap", false)

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

local neogit = require('neogit')
neogit.setup {}

require "buffers"
require "terminal"
require "hydra_def"

require('whitespace-nvim').setup({
    -- configuration options and their defaults

    -- `highlight` configures which highlight is used to display
    -- trailing whitespace
    highlight = 'DiffDelete',

    -- `ignored_filetypes` configures which filetypes to ignore when
    -- displaying trailing whitespace
    ignored_filetypes = { 'TelescopePrompt', '', 'NeogitPopup' },
})

-- remove trailing whitespace with a keybinding
vim.api.nvim_set_keymap(
    'n',
    '<Leader>t',
    [[<cmd>lua require('whitespace-nvim').trim()<CR>]],
    { noremap = true }
)
