set colorcolumn=80

" nmap ]] :call g:MyPythonJump('/^\s*\(class\\|def\)')<cr>
" nmap [[ :call g:MyPythonJump('?^\s*\(class\\|def\)')<cr>
" nmap ]m :call g:MyPythonJump('/^\s*\(class\\|def\)')<cr>
" nmap [m :call g:MyPythonJump('?^\s*\(class\\|def\)')<cr>
" nmap ]c :call g:MyPythonJump('/^\(class\\|def\)')<cr>
" nmap [c :call g:MyPythonJump('?^\(class\\|def\)')<cr>

" function! g:MyPythonJump(motion) range
    " let cnt = v:count1
    " let save = @/    " save last search pattern
    " mark '
    " while cnt > 0
        " silent! exe a:motion
        " let cnt = cnt - 1
    " endwhile
    " call histdel('/', -1)
    " let @/ = save    " restore last search pattern
" endfun

au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadSquare
