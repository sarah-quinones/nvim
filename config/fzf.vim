let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Todo', 'rounded': v:false } }

" Fuzzy find files in the working directory
nnoremap <silent> <leader>ff
      \ :call fzf#vim#files('', {'options': [
      \ '--cycle', '--preview-window', 'right',
      \ '--bind=ctrl-a:select-all,ctrl-d:deselect-all',
      \ '--preview', $LOCAL_HOME .
      \ '''/.local/share/nvim/plugged/fzf.vim/bin/preview.sh'' {}']},
      \ 0)<cr>

" nnoremap <silent> <leader>bb :Buffers<cr>
nnoremap <silent> <leader>bb
      \ :call fzf#vim#buffers('', {'options': [
      \ '-x', '--tiebreak=index', '--header-lines=0',
      \ '--ansi', '-d', '\t', '-n', '2,1..2', '--prompt', 'Buf> ', ]
      \ },
      \ 0)<cr>

nnoremap <silent> <leader>st
      \ :call fzf#vim#buffers('^term://', {
      \ 'options':['--cycle']}, 0)<cr>
nnoremap <silent> <leader>ss :BLines<cr>
nnoremap <silent> <leader>sb :Lines<cr>

" Fuzzy find text in the working directory
nnoremap <silent> <leader>sr :Rg<cr>

" Fuzzy find git commits
nnoremap <silent> <leader>gc :Commits<cr>
nnoremap <silent> <leader>gC :BCommits<cr>

" Ctrl actions
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:n_which_key_map.f = {}
let g:n_which_key_map.f.name = '+files'
let g:n_which_key_map.f.f = 'file'

let g:n_which_key_map.s = {}
let g:n_which_key_map.s.name = '+search'
let g:n_which_key_map.s.t = 'terminals'
let g:n_which_key_map.s.s = 'current-buffer'
let g:n_which_key_map.s.b = 'all-buffers'

if !has_key(g:n_which_key_map, 'g')
  let g:n_which_key_map.g = {}
endif
let g:n_which_key_map.g.name = '+git'
let g:n_which_key_map.g.c = 'commits'
let g:n_which_key_map.g.C = 'commits-current-file'

augroup FzfMappings
  autocmd!
  autocmd FileType fzf
        \ tnoremap <buffer> <c-h> <c-h>|
        \ tnoremap <buffer> <c-j> <c-j>|
        \ tnoremap <buffer> <c-k> <c-k>|
        \ tnoremap <buffer> <c-l> <c-l>|
        \ autocmd! TermGroup TermClose <buffer>
augroup end
