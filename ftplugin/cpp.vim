" cppman.vim
" This is essentially an adapted version of the cppman.vim script that is 
" included with cppman. Authored by Wei-Ning Huang (AZ) <aitjcize@gmail.com>
" and others.
"
"
" This program is free software; you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation; either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program; if not, write to the Free Software Foundation,
" Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
"
"
" Vim syntax file
" Language:	Man page
" Version Info:
" Last Change:	2021 Jan 05

if exists("b:cppman_loaded")
  finish
endif
let b:cppman_loaded = 1

" command! -bar -nargs=1 Cppman call cppman#Cppman(<q-args>) 
" command! -bar -nargs=1 Cppmant tabnew | call cppman#Cppman(<q-args>) 
" command! -bar -nargs=1 Cppmanv rightb vsp | call cppman#Cppman(<q-args>) 
" command! -bar -nargs=1 Cppmans split | call cppman#Cppman(<q-args>) 

setl keywordprg=:Cppman                                  
"setl iskeyword+=:,=,~,[,],*,!,<,> 
