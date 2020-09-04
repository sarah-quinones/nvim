setlocal matchpairs+=<:>
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

lcd .

function! Compile_asm(linenum)
  let line = getline(a:linenum)
  let defaults = [
        \ "// clang++ -std=c++2a -O3 -march=haswell -Iinclude",
        \ "// g++     -std=c++2a -O3 -march=haswell -Iinclude"
        \ ]
  if line !~ "^//.*"
    return Compile_asm_impl(defaults[a:linenum - 1])
  endif
  let compiler = split(a:line)[1]
  let compiler_list = ["gcc", "clang", "cc", "g++", "clang++", "c++"]
  if index(compiler_list, compiler) == -1
    return Compile_asm_impl(defaults[a:linenum - 1])
  endif
endfunction

function! Compile_asm_impl(line)
  let compiler = split(a:line)[1]
  let file_path = expand("%:p")
  let obj_path = "/tmp/" . expand("%:t:r") . "." . compiler . ".o"
  let asm_path = "/tmp/" . expand("%:t:r") . "." . compiler . ".s"
  let compile_cmd = a:line[3:] . " " . file_path . " -c -o " . obj_path
  let objdump_cmd = 'source "$ZDOTDIR_OLD/.zshrc" '
        \ . '&& disassemble ' . obj_path
        \ . "| sed '/^ *[0-f]*:\t00/d' > " . asm_path
  let delete_cmd = "rm " . obj_path
  echom compile_cmd
  echom objdump_cmd
  echom system(compile_cmd . " && " . objdump_cmd . " &&" . delete_cmd)
  return asm_path
endfunction

nnoremap <buffer><silent> [] :w <bar> call Compile_asm(1) <bar>
      \ call Compile_asm(2) <bar>
      \ checktime<cr>
