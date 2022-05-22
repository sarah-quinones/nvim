local actions = require "telescope.actions"
local action_state = require('telescope.actions.state')

local function edit_selected(prompt_bufnr, mode)
  local picker = action_state.get_current_picker(prompt_bufnr)
  actions.close(prompt_bufnr)

  local map = picker:get_multi_selection()
  if table.getn(map) == 0 then
    map = {action_state.get_selected_entry()}
  end

  for _, entry in ipairs(map) do
    vim.cmd(mode .. " " .. entry.filename)
  end
  vim.cmd("stopinsert")
end

local function edit_selected_current_win(prompt_bufnr)
  edit_selected(prompt_bufnr, "edit")
end
local function edit_selected_horizontal(prompt_bufnr)
  edit_selected(prompt_bufnr, "split")
end
local function edit_selected_vertical(prompt_bufnr)
  edit_selected(prompt_bufnr, "vsplit")
end
local function edit_selected_tab(prompt_bufnr)
  edit_selected(prompt_bufnr, "tabedit")
end

local edit_table = {
  ['<CR>'] = edit_selected_current_win,
  ['<C-s>'] = edit_selected_horizontal,
  ['<C-x>'] = edit_selected_horizontal,
  ['<C-v>'] = edit_selected_vertical,
  ['<C-t>'] = edit_selected_tab,
}

require("telescope").setup {
    defaults = {
        mappings = {
          i = edit_table,
          n = edit_table,
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                mirror = false,
                preview_width = 0.5
            },
            vertical = {
                mirror = false
            },
            width = 0.75,
            prompt_position = "bottom",
            preview_cutoff = 120,
        },
        file_sorter = require "telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {"vcpkg"},
        generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require "telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
    },
}

local opt = {noremap = true, silent = true}

-- mappings
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)

vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)

-- highlights 

vim.cmd "hi TelescopeBorder   guifg=#2a2e36"
vim.cmd "hi TelescopePromptBorder   guifg=#2a2e36"
vim.cmd "hi TelescopeResultsBorder  guifg=#2a2e36"
vim.cmd "hi TelescopePreviewBorder  guifg=#525865"
