setlocal sw=4 sts=4 ts=4
set cc=78
setlocal errorformat=%f:%l:\ %m

"au VimEnter * :UltiSnipsAddFiletypes cpp.c

map <buffer> <Leader>c :!g++ -Wall -o %:r %
map <buffer> <Leader>r :!<C-R>=fnamemodify(expand('%'),':p:r')<CR>
