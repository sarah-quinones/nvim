setlocal shiftwidth=4 softtabstop=4
set foldmethod=indent
let b:ale_linters = [
      \   'flake8',
      \   'pylint',
      \]
let b:ale_fixers = [
      \   'isort',
      \   'black',
      \]

let g:ale_python_flake8_options = '--ignore-errors=E121,E123,E126,E226,E24,E704,W503,W504'

nmap <silent> ]q <plug>(coc-diagnostic-next)
nmap <silent> [q <plug>(coc-diagnostic-prev)
nmap <silent> ]e <plug>(coc-diagnostic-next-error)
nmap <silent> [e <plug>(coc-diagnostic-prev-error)
