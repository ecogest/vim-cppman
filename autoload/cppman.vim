function! cppman#Cppman(page)
  " new
  " tab new
  enew
  setlocal bufhidden=delete
  setlocal noswapfile
  setlocal filetype=cppman

  let g:page_name = a:page

  setl nonu
  setl nornu
  setl noma
  setl buftype=nofile
  noremap <buffer> q :q!<CR>

  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif

  "syntax on
  syntax case ignore
  syntax match  manReference       "[a-z_:+-\*][a-z_:+-~!\*<>()]\+ ([1-9][a-z]\=)"
  syntax match  manTitle           "^\w.\+([0-9]\+[a-z]\=).*"
  syntax match  manSectionHeading  "^[a-z][a-z_ \-:]*[a-z]$"
  syntax match  manSubHeading      "^\s\{3\}[a-z][a-z ]*[a-z]$"
  syntax match  manOptionDesc      "^\s*[+-][a-z0-9]\S*"
  syntax match  manLongOptionDesc  "^\s*--[a-z0-9-]\S*"

  syntax include @cppCode runtime! syntax/cpp.vim
  syntax match manCFuncDefinition  display "\<\h\w*\>\s*("me=e-1 contained

  syntax region manSynopsis start="^SYNOPSIS"hs=s+8 end="^\u\+\s*$"me=e-12 keepend contains=manSectionHeading,@cppCode,manCFuncDefinition
  " syntax region manSynopsis start="^EXAMPLE"hs=s+7 end="^       [^ ]"he=s-1 keepend contains=manSectionHeading,@cppCode,manCFuncDefinition
  syntax region manSynopsis start="^EXAMPLE"hs=s+7 end="^[^ ].*$"re=s-1 keepend contains=manSectionHeading,@cppCode,manCFuncDefinition

  " Define the default highlighting.
  " For version 5.7 and earlier: only when not done already
  " For version 5.8 and later: only when an item doesn't have highlighting yet
  if version >= 508 || !exists("did_man_syn_inits")
    if version < 508
      let did_man_syn_inits = 1
      command -nargs=+ HiLink hi link <args>
    else
      command -nargs=+ HiLink hi def link <args>
    endif

    HiLink manTitle	      Title
    HiLink manSectionHeading  Statement
    HiLink manOptionDesc      Constant
    HiLink manLongOptionDesc  Constant
    HiLink manReference	      PreProc
    HiLink manSubHeading      Function
    HiLink manCFuncDefinition Function

    delcommand HiLink
  endif

  """ Vim Viewer
  setl mouse=a
  setl colorcolumn=0


  let g:stack = []

  noremap <buffer> K :call LoadNewPage()<CR>
  map <buffer> <CR> K
  map <buffer> <C-]> K
  map <buffer> <2-LeftMouse> K

  noremap <buffer> <silent> <C-T> :call BackToPrevPage()<CR>
  map <buffer> <RightMouse> <C-T>

  let b:current_syntax = "man"

  let s:old_col = 0 
  autocmd VimResized * call s:Rerender()

  " Open page
  call s:reload()
  if v:shell_error
    echo "No manual for '".g:page_name."'"
    quit
  else
    exec "0"
  endif
endfunction


function! s:reload()
  setl noro
  setl ma
  echo "Loading..."
  exec "%d"
  silent exec "0r! cppman --force-columns " . max([(winwidth(0) - 2),140]) . " '" . g:page_name . "'"
  redraw | echo ""
  exec "silent! %s/’/'/g"
  exec "file ".g:page_name
  normal! gg
  setl ro
  setl noma
  setl nomod
endfunction

function! s:Rerender()
  if winwidth(0) != s:old_col
    let s:old_col = winwidth(0) 
    let save_cursor = getpos(".")
    call s:reload()
    call setpos('.', save_cursor)
  end
endfunction

function! LoadNewPage()
  " Save current page to stack
  call add(g:stack, [g:page_name, getpos(".")])
  setl iskeyword+=:
  let g:page_name = expand("<cword>")
  setl iskeyword-=:
  setl noro
  setl ma
  call s:reload()
  normal! gg
  setl ro
  setl noma
  setl nomod
endfunction

function! BackToPrevPage()
  if len(g:stack) > 0
    let context = g:stack[-1]
    call remove(g:stack, -1)
    let g:page_name = context[0]
    call s:reload()
    call setpos('.', context[1])
  end
endfunction
