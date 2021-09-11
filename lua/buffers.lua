local M = {}

M._scratch = 0

function M.get_scratch()
  local found_scratch = (function ()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if M._scratch == buf then return true end
    end
    return false
  end)()

  if not found_scratch then
    local scratch = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(scratch, "/dev/null")
    vim.fn.setbufvar('/dev/null', '&buftype', 'nofile')
    vim.fn.setbufvar('/dev/null', '&bufhidden', 'hide')
    vim.fn.setbufvar('/dev/null', '&swapfile', 0)
    return scratch
  else
    return M._scratch
  end
end

M._scratch = M.get_scratch()

function M.delete_buffer_keep_windows(buf_nr, cmd)
  if buf_nr == 0 then
    local buf_nr = vim.api.nvim_get_current_buf()
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if buf_nr == buf then
      vim.api.nvim_win_set_buf(win, M.get_scratch())
    end
  end

  vim.cmd(f"{cmd} {buf_nr}")
end

function M.delete_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local bufname = vim.fn.bufname(buf)
    if starts_with(bufname, "term://") then
      vim.api.nvim_buf_delete(buf, {force = true})
    elseif string.len(bufname) > 0 and not starts_with(bufname, "/dev/null") then
      vim.api.nvim_buf_delete(buf, {force = false})
    end
  end
end

function M.set_scrolloff()
  local buftype = vim.api.nvim_buf_get_option(0, "buftype")
  if buftype == "terminal" then
    vim.api.nvim_set_option("scrolloff", 0)
  elseif buftype == "help" then
    vim.api.nvim_set_option("scrolloff", 999)
  else
    vim.api.nvim_set_option("scrolloff", 5)
  end
end

vim.cmd([[
  augroup scrolloff_group
    autocmd!
    autocmd WinEnter,BufEnter,TermOpen * lua require'buffers'.set_scrolloff()
  augroup end
]])

vim.cmd(
  "augroup scratch_buffer\n" ..
  "  autocmd VimEnter * if bufname('%') == '' | execute 'lua vim.api.nvim_win_set_buf(0, require\"buffers\".get_scratch())' | endif\n" ..
  "augroup end"
)

return M
