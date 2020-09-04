setlocal foldmethod=syntax
setlocal commentstring=//\ %s
let b:ale_linters = [
      \   'clangtidy',
      \]
let b:ale_fixers = [
      \   'clang-format',
      \]

let g:ale_cpp_clangtidy_checks=['-*'
      \]

nmap <silent> ]q <plug>(coc-diagnostic-next)
nmap <silent> [q <plug>(coc-diagnostic-prev)
nmap <silent> ]e <plug>(coc-diagnostic-next-error)
nmap <silent> [e <plug>(coc-diagnostic-prev-error)
