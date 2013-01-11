setlocal sw=4 sts=4 ts=4 et
setlocal errorformat=%f:%l:\ %m

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.\+/

if has("colorcolumn")
	set colorcolumn=78
endif
