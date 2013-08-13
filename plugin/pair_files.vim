" pair_files.vim -  open the corresponding source or test file based on
"                   current buffer
" Maintainer:       William Ting <io at williamting.com>

" helper functions

function! s:is_test_file(string)
    return a:string =~ '_test.py$'
endfunction

function! s:remove_test_suffix(string)
    return substitute(a:string, '_test.py$', '.py', '')
endfunction

function! s:remove_test_dir(string)
    return substitute(a:string, 'yelp\/tests\/', '', '')
endfunction

function! s:add_test_suffix(string)
    return substitute(a:string, '.py$', '_test.py', '')
endfunction

function! s:add_test_dir(string)
    return substitute(a:string, 'yelp-main', 'yelp-main\/yelp\/tests', '')
endfunction

" logic functions

function! s:get_test_pair(path)
    return s:add_test_dir(s:add_test_suffix(a:path))
endfunction

function! s:get_normal_pair(path)
    return s:remove_test_dir(s:remove_test_suffix(a:path))
endfunction

function! s:get_pair_file(path)
    return s:is_test_file(a:path) ? s:get_normal_pair(a:path) : s:get_test_pair(a:path)
endfunction

" public functions

function! g:EditPairFile(open_style)
    let l:file = s:get_pair_file(expand('%:p'))
    if l:file != expand('%:p') && filereadable(l:file)
        execute a:open_style . " " . l:file
    else
        echom "could not find pair file: " . l:file
    endif
endfunction

command! EditPairFile call g:EditPairFile('edit')
command! TabEditPairFile call g:EditPairFile('tabedit')
command! SplitEditPairFile call g:EditPairFile('split')
command! VSplitEditPairFile call g:EditPairFile('vsplit')
