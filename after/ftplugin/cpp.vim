setlocal matchpairs+=<:>
set foldmethod=marker
setlocal commentstring=//\ %s

function! Compile_asm(linenum)
  let line = getline(a:linenum)
  let defaults = [
        \ "// clang++ -DNDEBUG -std=c++20 -O3 -march=haswell -Iinclude",
        \ "// g++     -DNDEBUG -std=c++20 -O3 -march=haswell -Iinclude"
        \ ]
  if line !~ "^//.*"
    return Compile_asm_impl(defaults[a:linenum - 1])
  endif
  let compiler = split(line)[1]
  let compiler_list = ["gcc", "clang", "cc", "g++", "clang++", "c++", "clang++-11", "clang++-12"]
  if index(compiler_list, compiler) == -1
    return Compile_asm_impl(defaults[a:linenum - 1])
  else
    return Compile_asm_impl(line)
  endif
endfunction

function! Compile_asm_impl(line)
  let compiler = split(a:line)[1]
  let file_path = expand("%:p")
  let obj_path = "/tmp/" . expand("%:t:r") . "." . compiler . ".o"
  let asm_path = "/tmp/" . expand("%:t:r") . "." . compiler . ".s"
  let asm_path2 = "/tmp/asm." . expand("%:t:r") . "." . compiler . ".s"
  let compile_cmd = a:line[3:] . " " . file_path . " -c -o " . obj_path
  let asm_compile_cmd = a:line[3:] . " " . file_path . " -S -o " . asm_path2
  let objdump_cmd = 'source "$ZDOTDIR_OLD/.zshrc" '
        \ . '&& disassemble ' . obj_path
        \ . "| sed '/^ *[0-f]*:\t00/d' > " . asm_path
  let delete_cmd = "rm " . obj_path
  echom asm_compile_cmd
  echom compile_cmd
  echom objdump_cmd
  echom system(asm_compile_cmd . " && " . compile_cmd . " && " . objdump_cmd . " &&" . delete_cmd)
  return asm_path
endfunction

nnoremap <buffer><silent> [] :w <bar> call Compile_asm(1) <bar>
      \ call Compile_asm(2) <bar>
      \ checktime<cr>

function! Split_pipe()
  execute "s/ | /\\\/\\\/\r | "
endfunction
