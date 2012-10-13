setlocal ts=2 sw=2 sts=2 et

if has("colorcolumn")
	set colorcolumn=80
endif

map <buffer> <Leader>c :!ruby -c %
map <buffer> <Leader>r :!ruby %
