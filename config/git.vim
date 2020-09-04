" Signify mappings
nmap ]g <plug>(signify-next-hunk)
nmap [g <plug>(signify-prev-hunk)
nmap ]G 9999]g
nmap [G 9999[g

augroup SignifyDetectChange
  autocmd!
  autocmd TextChanged */.git/index SignifyRefresh
augroup end

nnoremap <leader>gf :SignifyFold!<cr>
nnoremap <leader>gh :SignifyToggleHighlight<cr>
nnoremap <leader>gg :SignifyHunkDiff<cr>

nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gw :Gwrite <bar> sleep 10m <bar> SignifyRefresh<cr>

nnoremap <leader>g-h :Gdiff HEAD<cr>
nnoremap <leader>g-- :Gdiff<cr>

nnoremap <leader>gee :Gedit<cr>
nnoremap <leader>gev :Gvsplit<cr>
nnoremap <leader>ges :Gsplit<cr>
nnoremap <leader>get :Gtabedit<cr>

nnoremap <leader>gd :Gdelete<cr>
nnoremap <leader>gm :Gmove ./

nnoremap <leader>gs :Git<cr>
nnoremap <leader>g<cr> :Gcommit<cr>

nnoremap <leader>gpp :Gpush<cr>
nnoremap <leader>gpl :Gpull<cr>

nnoremap <leader>sg :Ggrep<cr>

if !has_key(g:n_which_key_map, 'g')
  let g:n_which_key_map.g = {}
endif
let g:n_which_key_map.g.name = '+git'
let g:n_which_key_map.g.r = 'read-staged'
let g:n_which_key_map.g.w = 'stage-file'
let g:n_which_key_map.g.g = 'preview-hunk'
let g:n_which_key_map.g.d = 'remove'
let g:n_which_key_map.g.m = 'move'
let g:n_which_key_map.g.s = 'status'
let g:n_which_key_map.g.f = 'fold-diff'
let g:n_which_key_map.g.h = 'highlight-diff'
let g:n_which_key_map.g['<CR>'] = 'commit'
let g:n_which_key_map.s.g = 'git-grep'

let g:n_which_key_map.g['-'] = {}
let g:n_which_key_map.g['-'].name = '+diff'
let g:n_which_key_map.g['-'].h = 'head'
let g:n_which_key_map.g['-']['-'] = 'staged'

let g:n_which_key_map.g.e = {}
let g:n_which_key_map.g.e.name = '+edit-git-object'
let g:n_which_key_map.g.e.e = 'current-window'
let g:n_which_key_map.g.e.v = 'vertical-split'
let g:n_which_key_map.g.e.s = 'horizontal-split'
let g:n_which_key_map.g.e.t = 'new-tab'

let g:n_which_key_map.g.p = {}
let g:n_which_key_map.g.p.name = '+remote'
let g:n_which_key_map.g.p.p = 'push'
let g:n_which_key_map.g.p.l = 'pull'
