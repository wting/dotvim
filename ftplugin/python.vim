setlocal ts=4 sw=4 sts=4 et
setlocal makeprg=python\ %
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

if has("colorcolumn")
	set colorcolumn=80
endif

map <buffer> <Leader>c :!python %
map <buffer> <Leader>r :!python %
