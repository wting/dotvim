set colorcolumn=78
setlocal errorformat=%f:%l:\ %m

if &filetype != 'cpp'
  map <buffer> <Leader>c :!gcc -std=c99 -Wall -o %:r %
  map <buffer> <Leader>r :!<C-R>=fnamemodify(expand('%'),':p:r')<CR>
endif
