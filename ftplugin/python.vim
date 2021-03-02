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

nnoremap <buffer> <silent> ]q :ALENextWrap<cr>
nnoremap <buffer> <silent> [q :ALEPreviousWrap<cr>
