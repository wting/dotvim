set colorcolumn=80
highlight OverLength ctermbg=darkblue ctermfg=white guibg=#000087
match OverLength /\%81v.\+/

au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadSquare
