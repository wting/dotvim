set colorcolumn=78
setlocal errorformat=%f:%l:\ %m

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadSquare

if &filetype != 'cpp'
  map <buffer> <Leader>c :!clang -std=c99 -Wall -o %:r %
  map <buffer> <Leader>r :!<C-R>=fnamemodify(expand('%'),':p:r')<CR>
endif
