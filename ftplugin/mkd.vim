setlocal ts=4 sts=4 sw=4 et
setlocal spell spelllang=en_us
setlocal wrap
setlocal textwidth=76

if has("colorcolumn")
	set colorcolumn=80
endif

map <buffer> <Leader>c :!markdown % > %:r.html
map <buffer> <Leader>r :!open -a "Google Chrome" %:r.html
