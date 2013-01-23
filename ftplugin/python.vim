setlocal makeprg=python\ %
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
set colorcolumn=78

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

map <buffer> <Leader>c :!python %
map <buffer> <Leader>r :!python %
