if exists("g:cppman_plugin")
  finish
endif
let g:cppman_plugin = 1

command! -bar -nargs=1 Cppman call cppman#Cppman(<q-args>) 
command! -bar -nargs=1 Cppmant tabnew | call cppman#Cppman(<q-args>) 
command! -bar -nargs=1 Cppmanv rightb vsp | call cppman#Cppman(<q-args>) 
command! -bar -nargs=1 Cppmans split | call cppman#Cppman(<q-args>) 
