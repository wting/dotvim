setlocal cc=78
setlocal textwidth=80

setlocal errorformat=%f:%l:\ %m

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/
