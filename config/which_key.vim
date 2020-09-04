let g:which_key_vertical = 1
let g:which_key_position = 'botright'
let g:which_key_use_floating_win = 0
let g:which_key_timeout = 100
let g:which_key_display_names = {
      \ ' '         : '□'      ,
      \ '<CR>'      : '↵'      ,
      \ '<M-r>'     : 'Alt-r'      ,
      \ '<BS>'      : '⌫'      ,
      \ '<C-I>'     : '⇆'      ,
      \ '<TAB>'     : '⇆'      ,
      \ '<C-SPACE>' : 'Ctrl-□' ,
      \ }

call which_key#register('<Space>', 'g:which_key_map')
nnoremap <silent> <leader> :<c-u>let g:which_key_map = {} <bar>
      \ call extend(g:which_key_map, g:n_which_key_map) <bar>
      \ WhichKey '<space>'<cr>
vnoremap <silent> <leader> :<c-u>let g:which_key_map = {} <bar>
      \ call extend(g:which_key_map, g:v_which_key_map) <bar>
      \ WhichKeyVisual '<space>'<cr>

let g:which_key_map =  {}
let g:n_which_key_map =  {}
let g:v_which_key_map =  {}
augroup WhichKey
  autocmd!
  " Clear command line
  autocmd FileType which_key autocmd BufLeave <buffer> echo ''
augroup end

call which_key#register('<c-space>', 'g:which_key_map_ctrl')
nnoremap <silent> <c-space> :<c-u>let g:which_key_map_ctrl = {} <bar>
      \ call extend(g:which_key_map_ctrl, g:n_which_key_map_ctrl) <bar>
      \ WhichKey '<lt>c-space>'<cr>
vnoremap <silent> <c-space> :<c-u>let g:which_key_map_ctrl = {} <bar>
      \ call extend(g:which_key_map_ctrl, g:v_which_key_map_ctrl) <bar>
      \ WhichKeyVisual '<lt>c-space>'<cr>

let g:which_key_map_ctrl =  {}
let g:n_which_key_map_ctrl =  {}
let g:v_which_key_map_ctrl =  {}
augroup WhichKey
  autocmd!
  " Clear command line
  autocmd FileType which_key autocmd BufLeave <buffer> echo ''
augroup end

