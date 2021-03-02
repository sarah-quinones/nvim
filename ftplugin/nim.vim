setlocal foldmethod=syntax
let b:ale_fixers = [
      \   'nimpretty',
      \ ]

if !has_key(g:n_which_key_maplocal, &filetype)
  let g:n_which_key_maplocal['nim'] = {}
endif
let g:n_which_key_maplocal['nim'].q = 'format'

nnoremap <buffer><silent> ,q :ALEFix<cr>
