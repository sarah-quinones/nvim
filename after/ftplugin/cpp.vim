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
  let compiler_list = ["gcc", "clang", "cc", "g++", "clang++", "c++"]
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

  let intel_asm_path = "/tmp/" . expand("%:t:r") . ".intel." . compiler . ".s"
  let att_asm_path = "/tmp/" . expand("%:t:r") . ".att." . compiler . ".s"

  let compile_cmd = a:line[3:] . " " . file_path . " -c -o " . obj_path

  let intel_disassemble = 'disassemble -M intel '
  let att_disassemble = 'disassemble -M att '

  let objdump_cmd_prefix = 'source "$ZDOTDIR_OLD/.zshrc" &&'
  let objdump_cmd_suffix = obj_path
        \ . "| sed '/^ *[0-f]*:\t00/d' > "

  let intel_objdump = objdump_cmd_prefix . intel_disassemble . objdump_cmd_suffix . intel_asm_path
  let att_objdump = objdump_cmd_prefix . att_disassemble . objdump_cmd_suffix . att_asm_path

  let delete_cmd = "rm " . obj_path
  echom compile_cmd
  echom intel_objdump
  echom att_objdump
  echom system(compile_cmd . " && " . intel_objdump . "&&" . att_objdump . " &&" . delete_cmd)
endfunction

nnoremap <buffer><silent> [] :w <bar> call Compile_asm(1) <bar>
      \ call Compile_asm(2) <bar>
      \ checktime<cr>

function! Split_pipe()
  execute "s/ | /\\\/\\\/\r | "
endfunction
