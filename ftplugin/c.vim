set colorcolumn=80
highlight OverLength ctermbg=238
match OverLength /\%81v.\+/

noremap <silent> <buffer> [[ ?{<CR>w99[{
noremap <silent> <buffer> ]] j0?{<CR>w99[{%/{<CR>

au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
