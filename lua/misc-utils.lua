function f(str)
   local outer_env = _ENV
   return (str:gsub("%b{}", function(block)
      local code = block:match("{(.*)}")
      local exp_env = {}
      setmetatable(exp_env, { __index = function(_, k)
         local stack_level = 5
         while debug.getinfo(stack_level, "") ~= nil do
            local i = 1
            repeat
               local name, value = debug.getlocal(stack_level, i)
               if name == k then
                  return value
               end
               i = i + 1
            until name == nil
            stack_level = stack_level + 1
         end
         return rawget(outer_env, k)
      end })
      local fn, err = load("return "..code, "expression `"..code.."`", "t", exp_env)
      if fn then
         return tostring(fn())
      else
         error(err, 0)
      end
   end))
end

function starts_with(str, start)
   return str:sub(1, string.len(start)) == start
end

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

vim.cmd("set matchpairs+=<:>")
opt("o", "undofile", true)
opt("o", "hidden", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "number", true)
opt("o", "numberwidth", 2)
opt("w", "cul", true)
opt("o", "inccommand", "split")

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 2)

opt("o", "scrolloff", 5)
opt("o", "updatetime", 500) -- update interval for gitsigns

-- for indenline
opt("b", "expandtab", true)
opt("b", "tabstop", 2)
opt("b", "shiftwidth", 2)

-- highlight yanked text
vim.cmd([[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 300})
  augroup end
]])


local M = {}

function M.is_buffer_empty()
    -- check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

function M.search_selection(fwd)
  vim.cmd([[
    let temp = @"
    normal! gvy
    let @/ = substitute(@", '\\', '\\\\', 'g')
    let @/ = substitute(@/, '\/', '\\\/', 'g')
    let @/ = substitute(@/, '\n', '\\n', 'g')
    let @/ = '\C\V' . @/
    let @" = temp
  ]])
  vim.cmd(f"let v:searchforward={fwd}")
  vim.api.nvim_set_option("hlsearch", true)
end

return M
