if vim.env.ZDOTDIR ~= vim.env.VIMCONFIG .. "/config/" then
  vim.env.ZDOTDIR_OLD = vim.env.ZDOTDIR
end

vim.env.ZDOTDIR = vim.env.VIMCONFIG .. "/config/"

vim.api.nvim_set_option("shell", vim.env.SHELL)
vim.api.nvim_set_option("scrollback", 100000)

vim.cmd([[
  augroup terminal_group
    autocmd!
    autocmd TermOpen * lua require'terminal'.on_term_open(vim.fn.expand("<abuf>"))
    autocmd WinEnter,BufEnter term://* lua require'terminal'.on_term_enter()
  augroup end
]])

local M = {}

function M.on_term_enter()
  for _, prefix in ipairs({"", "M-", "C-"}) do
    vim.api.nvim_buf_set_keymap(0, "n", f"<{prefix}CR>", "a", {noremap = true})
  end
end

function M.on_term_close(buf_nr)
  buf_nr = tonumber(buf_nr)
  require "buffers".delete_buffer_keep_windows(buf_nr, "bwipeout!")
  if starts_with(vim.fn.bufname(), "term://") then
    vim.cmd([[
      filetype detect
      stopinsert
      set scrolloff=5
    ]])
  end
end

function M.on_term_open(buf_nr)
  buf_nr = tonumber(buf_nr)
  if buf_nr == vim.api.nvim_get_current_buf() then
    vim.cmd("startinsert")
    M.on_term_enter()
  end
  vim.cmd([[
    augroup terminal_group_cont
      autocmd TermClose <buffer> lua require'terminal'.on_term_close(vim.fn.expand("<abuf>"))
    augroup end
  ]])
end

return M
