setlocal spell spelllang=en_us
setlocal wrap

setlocal fo=tcqbl
setlocal cc=78
setlocal textwidth=80

"map <buffer> <Leader>c :!markdown % > %:r.html
"map <buffer> <Leader>r :!open -a "Google Chrome" %:r.html
