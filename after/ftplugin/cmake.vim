setlocal foldmethod=syntax
let g:neoformat_cmake_cmake_format = {
            \ 'exe': 'cmake-format',
            \ 'args': ['-c .cmake-format.yaml', '--'],
            \}
let g:neoformat_enabled_cmake = ['cmake_format']
