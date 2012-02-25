setlocal ts=4 sw=4 sts=4

if has("colorcolumn")
	set colorcolumn=80
endif

map <buffer> <Leader>c :!javac %
map <buffer> <Leader>r :!java %:r
