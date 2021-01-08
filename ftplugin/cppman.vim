" Vim syntax file
" Language:	Man page

if exists("b:cppman_loaded")
  finish
endif
let b:cppman_loaded = 1

nnoremap <silent><buffer> gO :call toc_cppman#show_toc()<cr>
