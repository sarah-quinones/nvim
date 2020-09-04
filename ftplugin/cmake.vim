setlocal foldmethod=syntax
let b:ale_fixers = [
      \   'cmakeformat',
      \ ]
let g:ale_cmake_cmakeformat_options = '-c .cmake-format.yaml -- '
let g:ale_cmake_cmakeformat_executable = $HOME . '/.local/share/nvim/venv/bin/cmake-format'

if !has_key(g:n_which_key_maplocal, &filetype)
  let g:n_which_key_maplocal['cmake'] = {}
endif
let g:n_which_key_maplocal['cmake'].q = 'format'

nnoremap <buffer><silent> ,q :ALEFix<cr>
