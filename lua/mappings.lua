local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local modes = {"n", "i", "v", "t"}
local opt = {}
local term_exit = "<C-\\><C-n>"

-- altgr characters --
for _, char in ipairs({"¹", "²", "³", "€", "×", "÷", "µ", "ç", "é"}) do
  map("i", f"<M-{char}>", char, opt)
end

for _, mode in ipairs({"n", "v"}) do
  map(mode, ":", ",", opt)
  map(mode, "\\", ":", opt)
end

map("n", "Q", "gq", opt)

map("n", "<Leader>", "<NOP>", opt)
map("n", "<LocalLeader>", "<NOP>", opt)


map("n", "<BS>", "<NOP>", opt)
map("n", "<C-]>", "<NOP>", opt)

-- turn off highlighting --
for _, mode in ipairs(modes) do
  map(mode, "<M-.>", "<Cmd> nohlsearch | echo<CR>", opt)
end

-- coc
map("n", "<LocalLeader><M-r>", "<Cmd> CocRestart<CR>", {})
map("n", "<LocalLeader>r", "<Cmd> w | call CocActionAsync('rename')<CR>", {})
map("n", "<LocalLeader>h", "<Cmd> w | call CocActionAsync('doHover')<CR>", {})
map("n", "<LocalLeader>q", "<Cmd> Neoformat<CR>", opt)
vim.api.nvim_set_keymap("n", "<LocalLeader>R", "<Plug>(coc-refactor)", {})
vim.api.nvim_set_keymap("n", "<LocalLeader>f", "<Plug>(coc-fix-current)", {})
vim.api.nvim_set_keymap("n", "<LocalLeader>i", "<Plug>(coc-implementation)", {})
vim.api.nvim_set_keymap("n", "<LocalLeader>t", "<Plug>(coc-type-definition)", {})
vim.api.nvim_set_keymap("n", "<LocalLeader>s", "<Plug>(coc-references)", {})

for key1, name in pairs({d = "Definition", D = "Declaration"}) do
  for key2, arg in pairs({[key1] = "", s = "split", v = "vsplit", t = "tabedit"}) do
    if arg ~= "" then
      arg = f", '{arg}'"
    end
    map("n", f"<LocalLeader>{key1}{key2}", f"<Cmd> call CocActionAsync('jump{name}'{arg})<CR>", opt)
  end
end

vim.api.nvim_set_keymap("n", "]q", "<Plug>(coc-diagnostic-next)", {})
vim.api.nvim_set_keymap("n", "[q", "<Plug>(coc-diagnostic-prev)", {})
vim.api.nvim_set_keymap("n", "]e", "<Plug>(coc-diagnostic-next-error)", {})
vim.api.nvim_set_keymap("n", "[e", "<Plug>(coc-diagnostic-prev-error)", {})
vim.api.nvim_set_keymap("i", "<C-s>", "<Plug>(coc-snippets-expand)", opt)
vim.api.nvim_set_keymap("v", "<C-s>", "<Plug>(coc-snippets-select)", opt)

vim.g.coc_snippet_next = '<C-j>'
vim.g.coc_snippet_prev = '<C-k>'

-- easymotion
for _, char in ipairs({"j", "k", "s", "f", "t", "F", "T", "w", "e", "b", "W", "E", "B"}) do
  vim.api.nvim_set_keymap("n", f"<M-{char}>", f"<Plug>(easymotion-{char})", {silent=true})
end
vim.api.nvim_set_keymap("n", f"<M-l>", "<Plug>(easymotion-overwin-line)", {silent=true})
vim.api.nvim_set_keymap("n", f"<M-n>", "<Plug>(easymotion-ge)", {silent=true})
vim.api.nvim_set_keymap("n", f"<M-N>", "<Plug>(easymotion-gE)", {silent=true})

-- command mode mappings
map("c", "<C-p>", "<up>", opt)
map("c", "<C-n>", "<down>", opt)

map("c", "<C-h>", "<left>", opt)
map("c", "<C-j>", "<down>", opt)
map("c", "<C-k>", "<up>", opt)
map("c", "<C-l>", "<right>", opt)

map("c", "<M-h>", "<left><left>", opt)
map("c", "<M-l>", "<right><right>", opt)

map("c", "<C-a>", "<C-b>", opt)
map("c", "<C-e>", "<C-e>", opt)

map("c", "((", "\\(\\)<left><left>", opt)
map("c", "!!", "\\@!", opt)
map("c", "**", "\\{-}", opt)
map("c", "<Bar><Bar><Bar>", "\\(\\<Bar>\\)<left><left><left><left>", opt)

-- yank/paste
map("n", "Y", 'y$', opt)
for _, mode in ipairs({"n", "v"}) do
  map(mode, "<Leader>y", '"+y', opt)
end
map("v", "<M-p>", '"+p', opt)
map("v", "P", 'pgvy`>', opt)

-- insert mode movement
map("i", "<C-h>", "<left>", opt)
map("i", "<C-l>", "<right>", opt)

-- switch HL with ^$
for _, mode in ipairs({"n", "v", "o"}) do
  map(mode, "H", "^", opt)
  map(mode, "^", "H", opt)
  map(mode, "L", "$", opt)
  map(mode, "$", "L", opt)
end

map("n", "/", ":set hlsearch<CR>/", opt)
map("n", "?", ":set hlsearch<CR>?", opt)

for key, fwd in pairs({["*"] = 1, ["#"] = 0}) do
  map("n", key, 
    "<Cmd>let @/ = '\\<'.expand('<cword>').'\\>'" ..
    f"<Bar> let v:searchforward={fwd}" ..
    "<Bar> set hlsearch<CR>", {silent = true})
  map("x", key, f"<Esc>:lua require 'misc-utils'.search_selection({fwd})<CR>", {silent = true})
end

map("n", "<C-Space>d", "<Cmd>close<CR>", opt)
map("n", "<C-Space>D", "<Cmd>tabclose<CR>", opt)
map("n", "<C-Space>q", "<Cmd>bdelete<CR>", opt)
map("n", "<C-Space>Q", "<Cmd>bdelete!<CR>", opt)
map("n", "<C-Space>=", "<C-w>=", opt)

map("n", "<C-Space><C-Space>", "<Cmd>terminal<CR>", opt)
map("t", "<C-Space><C-Space>", "<C-Space>", opt)
map("t", "<C-Space><C-l>", "<C-l>", opt)
map("t", "<C-Space>l", "<C-l>", opt)

-- navigation --
map("n", "<Leader>qe", "<Cmd> lcd $VIMCONFIG | edit init.lua<CR>", {})
map("n", "<Leader><Tab>", "<C-^>", {})
for mode, prefix in pairs({n = "", t = term_exit}) do
  for i=1,9 do
    map(mode, f"<C-{i}>", f"{prefix}{i}gt", opt)
  end

  map(mode, "<C-Tab>", prefix .. "gt", opt)
  map(mode, "<C-S-Tab>", prefix .. "gT", opt)
  map(mode, "<C-Space>o", "<Cmd> tab split <CR>")

  for _, char in ipairs({"l", "h", "j", "k"}) do
    map(mode, f"<C-{char}>", f"{prefix}<C-w>{char}", opt)
    if mode == "t" then
      map(mode, f"<C-Space><C-{char}>", f"<C-{char}>", opt)
    end
  end

  map(mode, "<C-Space>s", "<Cmd>new    <Bar> terminal<CR>", {silent = true})
  map(mode, "<C-Space>v", "<Cmd>vnew   <Bar> terminal<CR>", {silent = true})
  map(mode, "<C-Space>t", "<Cmd>tabnew <Bar> terminal<CR>", {silent = true})
end
for _, char in ipairs({"p", "P"}) do
  map("n", f"<M-{char}>", f'"+{char}' , opt)
end

map("t", f"<M-p>", f'{term_exit}"+pa', opt)
map("t", f"<M-P>", f'{term_exit}pa', opt)
for _, char in ipairs({"p", "P"}) do
  map("t", f"<C-Space><M-{char}>", f"<M-{char}>", opt)
end

map("n", "<C-w>o", "<Nop>", opt)
vim.api.nvim_set_keymap("n", "<C-w>p", "<Plug>(coc-float-jump)", {})

map("t", "<C-BS>", "<BS>", opt)
map("t", "<S-BS>", "<BS>", opt)
map("t", "<C-S-BS>", "<BS>", opt)

map("n", "<Leader>qq",
  "<Cmd> echon 'Quit? (press y to confirm): ' <Bar> " ..
  "if tolower(nr2char(getchar())) == 'y' <Bar> " ..
  "execute \"bufdo if bufname() !~ 'term://*' <Bar> bdelete <Bar> endif\" <Bar> qa <Bar> " ..
  "else <Bar> echo \"\\n\\n\" " ..
  "<Bar> endif<CR>" , opt)

-- supertab
vim.g.SuperTabDefaultCompletionType = "<C-n>"
vim.cmd([[
  augroup SuperTabConfig
  autocmd!
  autocmd VimEnter * imap <silent> <tab> <plug>SuperTabForward
  autocmd VimEnter * imap <silent> <s-tab> <plug>SuperTabBackward
  augroup end
]])

map("n", "<Leader>bD", f":lua require 'buffers'.delete_buffers()<CR>", {silent = true})

map("n", "<C-S-PageDown>", f":+tabmove<CR>", {silent = true})
map("n", "<C-S-F11>", f":+tabmove<CR>", {silent = true})
map("n", "<C-S-PageUp>", f":-tabmove<CR>", {silent = true})
map("n", "<C-S-F10>", f":-tabmove<CR>", {silent = true})

map("t", "<C-S-PageDown>", f"{term_exit}:+tabmove<CR>a", {silent = true})
map("t", "<C-S-F11>", f"{term_exit}:+tabmove<CR>a", {silent = true})
map("t", "<C-S-PageUp>", f"{term_exit}:-tabmove<CR>a", {silent = true})
map("t", "<C-S-F10>", f"{term_exit}:-tabmove<CR>a", {silent = true})
