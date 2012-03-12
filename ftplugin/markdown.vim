setlocal ts=4 sts=4 sw=4
setlocal formatoptions=wtan2l textwidth=80
setlocal spell spelllang=en_us

if has("colorcolumn")
	set colorcolumn=80
endif

map <buffer> <Leader>c :!markdown % > %:r.html
map <buffer> <Leader>r :!open -a "Google Chrome" %:r.html
