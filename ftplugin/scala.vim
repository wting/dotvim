setlocal ts=4 sw=4 sts=4 noet

if has("colorcolumn")
	set colorcolumn=80
endif

map <buffer> <Leader>c :!scalac %
map <buffer> <Leader>r :!scala %:r
