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

function! s:remove_test_dir(path)
    if a:path =~ '_cmds\/'
        return substitute(a:path, 'yelp\/tests\/', '', '')
    else
        return substitute(a:path, 'yelp\/tests\/', 'yelp\/', '')
    endif
endfunction

function! s:add_test_suffix(string)
    return substitute(a:string, '.py$', '_test.py', '')
endfunction

function! s:add_test_dir(path)
    if a:path =~ 'yelp\/'
        return substitute(a:path, 'yelp\/', 'yelp\/tests\/', '')
    else
        return substitute(a:path, 'yelp-main', 'yelp-main\/yelp\/tests', '')
    endif
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
    let l:current_file = expand('%:p')
    let l:pair_file = s:get_pair_file(l:current_file)
    if l:pair_file != l:current_file && filereadable(l:pair_file)
        execute a:open_style . " " . l:pair_file
    else
        echom "could not find pair file: " . l:pair_file
    endif
endfunction

command! PairFileEdit call g:EditPairFile('edit')
command! PairFileTabEdit call g:EditPairFile('tabedit')
command! PairFileSplitEdit call g:EditPairFile('split')
command! PairFileVSplitEdit call g:EditPairFile('vsplit')
