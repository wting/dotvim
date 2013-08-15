" io at williamting.com
" https://github.com/wting/dotvim
"
" Sections:
"    -> Vundle Configuration
"    -> Vundle Plugins
"    -> General Settings
"    -> GVIM
"    -> Statusline
"    -> Colors and Fonts
"    -> Files
"    -> General Functions
"    -> General Abbrevs
"    -> Moving Around
"    -> Mappings
"    -> Text, Tab and Indent
"    -> Plugin Options
"    -> Work

set nocompatible
filetype on				" disable OS X exit with non-zero error code
filetype off			" disabled to work around vundle ftdetect bug


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Configuration
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Features
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'camelcasemotion'
Bundle 'scrooloose/nerdtree'
" Bundle 'scrooloose/nerdcommenter'
Bundle 'wting/nerdcommenter'
Bundle 'bufexplorer.zip'
Bundle 'wting/gitsessions.vim'
Bundle 'kien/ctrlp.vim'
" Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'AndrewRadev/switch.vim'
Bundle 'sjl/gundo.vim'
" Bundle 'Lokaltog/vim-easymotion'
" skwp's version supports two character targets
Bundle 'skwp/vim-easymotion'

Bundle 'brookhong/cscope.vim'
Bundle 'vim-scripts/AutoTag'

" Powerline
Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-powerline'
Bundle 'wting/vim-powerline'
" Bundle 'Lokaltog/powerline'

" Appearance
Bundle 'vim-scripts/CSApprox'
Bundle 'guns/xterm-color-table.vim'
" Bundle 'kien/rainbow_parentheses.vim'
Bundle 'wting/rainbow_parentheses.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'kshenoy/vim-signature'
" Bundle 'wting/vim-signature'
Bundle 'airblade/vim-gitgutter'

" Syntax
" Bundle 'Soares/python.vim'
Bundle 'wting/rust.vim'
Bundle 'scrooloose/syntastic'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'vim-scripts/haskell.vim'
Bundle 'kchmck/vim-coffee-script'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
filetype plugin indent on
syntax enable

set ofu=syntaxcomplete#Complete
set history=1000
set undolevels=1000
set title                				"change the terminal's title
set backspace=indent,eol,start 			"allow backspace over everything
set iskeyword=@,48-57,_,192-255
set modelines=0							"remove modelines, prevents a few security exploits
set hidden
set splitright
set splitbelow
set ttyfast
set ruler
set visualbell
set noerrorbells
set showmode
set showcmd
set scrolloff=4
set nowrap
set formatoptions=qrn1
if v:version >= 703 && has('patch541')
    set fo+=j
endif

" set number
if exists("&relativenumber")
    set relativenumber
    augroup vimrc-relative_number
        silent! au InsertEnter * set number
        silent! au InsertLeave * set relativenumber
        silent! au FocusLost *   set number
        silent! au FocusGained * set relativenumber
    augroup END
endif

" search options
set ignorecase
set smartcase							"disable ignore case if uppercase present
set gdefault
set incsearch
set hlsearch
set showmatch

" disable vim regex, use Perl/Python regex instead
nnoremap / /\v
vnoremap / /\v

"change default grep behavior
set grepprg=gp\ -n

" YankStack must be called before other mappings
" call yankstack#setup()

" automatically resize vertical splits.
augroup vimrc-vertical_splits
    au WinEnter * set winfixheight
    au WinEnter * wincmd =
augroup END

" fix slight delay after pressing ESC then O: http://ksjoberg.com/vim-esckeys.html
" set noesckeys
set timeout timeoutlen=1000 ttimeoutlen=100

" set folds, default open
set foldmethod=indent
set foldlevel=20
set foldlevelstart=20
set showtabline=2

" remove trailing whitespace
function! StripTrailingWhitespaces()
    " prelude
    let _s=@/
    let l = line(".")
    let c = col(".")
    " business time
    %s/\s\+$//e
    " epilogue
    let @/=_s
    call cursor(l, c)
endfunction
augroup vimrc-strip_ws
    au BufWritePre * :call StripTrailingWhitespaces()
augroup END

" TODO: check that it works (2013.06.06_2225, ting)
" http://vim.wikia.com/wiki/Cscope
if has('cscope')
    " prevents jumping to first tag
    set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set vb t_vb=
set guioptions-=T


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%<%y\ b%n\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set shortmess=a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" force 256 color support even if terminal doesn't allow it
set t_Co=256
" shows the current line in different color
set cursorline

" let g:zenburn_high_Contrast = 1
" let g:zenburn_force_dark_Background = 1
" let g:zenburn_unified_CursorColumn = 1
colorscheme zenburn

" highlight current line
au ColorScheme * hi CursorLine term=underline ctermbg=darkblue

" dark tab display for indent guides
set background=dark

" hlsearch color
hi! Search term=reverse ctermfg=255 ctermbg=130

" make sign column same color as theme
"highlight clear SignColumn
hi! link SignColumn LineNr


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" au BufWritePost .vimrc so $MYVIMRC
set enc=utf-8
set fenc=utf-8
set nobackup
set wildmenu
set wildmode=list:longest
set wildignore+=*.DS_Store                                  " OSX bullshit
set wildignore+=.hg,.git,.svn                               " Version control
set wildignore+=*.sw?,*.un?                                 " vim
set wildignore+=*.aux,*.out,*.toc                           " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg              " binary images
set wildignore+=*.o,*.obj,*.so,*.a,*.exe,*.dll,*.manifest   " compiled object files
set wildignore+=*.spl                                       " compiled spelling word lists
set wildignore+=*.class                                     " Java
set wildignore+=*/venv/*,*.pyc                              " Python
set wildignore+=*/tmp/*,*.so,*.zip

set tags=./tags;/

" forgot sudo?
cnoremap w!! w !sudo tee % >/dev/null

silent !mkdir -p ~/.vim/tmp/backup &>/dev/null
set backupdir=~/.vim/tmp/backup
set backup

silent !mkdir -p ~/.vim/tmp/swap &>/dev/null
set directory=~/.vim/tmp/swap
set noswapfile

if has("persistent_undo")
    silent !mkdir -p ~/.vim/tmp/undo &>/dev/null
    set undodir=~/.vim/tmp/undo
    set undofile
endif

" auto save/load folds
silent !mkdir -p ~/.vim/tmp/view &>/dev/null
set viewdir=~/.vim/tmp/view
augroup vimrc-folds
    au BufWinEnter * silent! loadview
    au BufWinLeave * silent! mkview
augroup END


" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Tell vim to remember certain things when we exit
"  '50   :  marks will be remembered for up to  previously edited files
"  "1000 :  will save up to 100 lines for each register
"  :30   :  up to 20 lines of command-line history will be remembered
"  %     :  saves and restores the buffer list
"  n...  :  where to save the viminfo files
set viminfo='50,\"1000,:30,%,n~/.vim/tmp/viminfo


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" my session management
function! MySessionFile()
    return $HOME . '/.vim/tmp/mysession.vim'
endfunction

function! MySaveSession()
    let l:sessionfile = MySessionFile()
    exe "mksession! " . l:sessionfile
    echom "session created: " . l:sessionfile
endfunction

function! MyLoadSession()
    let l:sessionfile = MySessionFile()
    if (filereadable(l:sessionfile))
        echom "session loaded: " . l:sessionfile
        exe 'source ' l:sessionfile
    else
        echom "session not found: " . l:sessionfile
    endif
endfunction

command! MSS call MySaveSession()
command! MLS call MyLoadSession()

" open shell command in new scratch buffer
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    echo a:cmdline
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'You entered:    ' . a:cmdline)
    call setline(2, 'Expanded Form:  ' .expanded_cmdline)
    call setline(3,substitute(getline(2),'.','=','g'))
    execute '$read !'. expanded_cmdline
    setlocal nomodifiable
    1
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ca vhe vert help
ca waq wqa
ca nw set nowrap

ca tv :tabe $MYVIMRC<cr>
ca vv :vs $MYVIMRC<cr>
ca va :vs ~/custom/aliases<cr>
ca ta :tabe ~/custom/aliases<cr>
ca vg :vs ~/.gitconfig<cr>
ca tg :tabe ~/.gitconfig<cr>
ca vc :vs ~/pg/yelp-main/config/custom.py<cr>
ca tc :tabe ~/pg/yelp-main/config/custom.py<cr>
ca rfv so $MYVIMRC

" paste
ca p set paste
ca np set nopaste

" buffers
" ca sb sb
ca vb vert sb
ca tb tabnew | b

" typos
ca w' w
ca w" w

" switches
ca t2s :%s/\t/    / | noh
ca s2t :%s/    /\t/ | noh
ca "2' :s/"/'/ | noh
ca '2" :s/'/"/ | noh

" add / subtract operator spacing
nnoremap <leader>aos :s/\v([+-/*=])/ \1 /<cr> :noh<cr>
nnoremap <leader>sos :s/\v ([+-/*=]) /\1/<cr> :noh<cr>
ca add_op_space s/\v([+-/*=])/ \1 /
ca sub_op_space s/\v ([+-/*=]) /\1/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving Around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move between tabs
inoremap <silent> <c-h> <esc>:tabprev<cr>
inoremap <silent> <c-l> <esc>:tabnext<cr>
noremap <silent> <c-h> :tabprev<cr>
noremap <silent> <c-l> :tabnext<cr>

" no arrow keys allowed
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" redraw screen and remove search highlights
nnoremap <silent> = :noh<cr>

" navigate wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" general movement
nmap <s-k> <pageup>
nmap <space> <pagedown>
nmap n nzz
nmap N Nzz
nnoremap H ^
nnoremap L $

" # FIXME: fix sections with K&R braces (2013.06.17_1207, wting)
" http://vimdoc.sourceforge.net/htmldoc/motion.html#section
" nnoremap [[ ?{<cr>w99[{
" " nnoremap ]] j0[[%/{<cr>
" nnoremap ]] ?{<cr>w99[{%
" nnoremap ][ /}<cr>b99]}
" nnoremap [] k$][%?}<cr>

" Buffer Specific ^o and ^i
" http://stackoverflow.com/questions/7066456/vim-how-to-prevent-jumps-out-of-current-buffer
" http://stackoverflow.com/a/7075070/195139

" function! JumpInFile(back, forw)
    " let [n, i] = [bufnr('%'), 1]
    " let p = [n] + getpos('.')[1:]
    " sil! exe 'norm!1' . a:forw
    " while 1
        " let p1 = [bufnr('%')] + getpos('.')[1:]
        " if n == p1[0] | break | endif
        " if p == p1
            " sil! exe 'norm!' . (i-1) . a:back
            " break
        " endif
        " let [p, i] = [p1, i+1]
        " sil! exe 'norm!1' . a:forw
    " endwhile
" endfunction

" nnoremap <silent> <c-k> :call JumpInFile("\<c-i>", "\<c-o>")<cr>
" nnoremap <silent> <c-j> :call JumpInFile("\<c-o>", "\<c-i>")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

" exit insert mode
inoremap jj <esc>j
cnoremap jj <C-c>j
inoremap kk <esc>k
cnoremap kk <C-c>k

" save and quit
inoremap ZZ <esc>:wq<cr>
nnoremap ZA :wqa<cr>

" reduce keystrokes for command mode
inoremap ;w <esc>:w<cr>a
nnoremap ; :

" return cursor to previous position after dot command
" nnoremap . mz.`zmz

" toggle line numbers
nnoremap <c-n><c-n> :set invnumber<cr>

" default to line visual block selection
nnoremap v V

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<cr>

" rebind to modify window heights
if bufwinnr(1)
    nnoremap + <c-w>+
    nnoremap - <c-w>-
endif

" formatting current paragraph / selection
vnoremap Q gq
nnoremap Q gqap

" lower / upper case words
inoremap <c-d> <esc>ddi
inoremap <c-u> <esc>gUiwi

" open tag as split / vertical split / tab
nnoremap <c-\> :sp <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <c-\><c-\> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <c-\><c-\><c-\> :tab split<cr>:exec("tag ".expand("<cword>"))<cr>

" manipulate text using alt + hjkl
" FIXME: use alt key mappings (2013.06.06_2218, ting)
nnoremap <a-j> :m+<cr>==
nnoremap <a-k> :m-2<cr>==
nnoremap <a-h> <<
nnoremap <a-l> >>
inoremap <a-j> <esc>:m+<cr>==gi
inoremap <a-k> <esc>:m-2<cr>==gi
inoremap <a-h> <esc><<`]a
inoremap <a-l> <esc>>>`]a
vnoremap <a-j> :m'>+<cr>gv=gv
vnoremap <a-k> :m-2<cr>gv=gv
vnoremap <a-h> <gv
vnoremap <a-l> >gv

" insert lines above/below
" FIXME: create mapping for insert line above (2013.06.06_2219, ting)
" nnoremap <s-enter> O<cr><esc>
nnoremap <cr> o<esc>

" make Y behave like other capitals
map Y y$

" yank and paste from system register / clipboard
vnoremap <c-y><c-y> "+y
nnoremap <c-p><c-p> "+p


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab and Indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set tabstop=4
set shiftwidth=4
set shiftround 				" use multiples of shiftwidth when using < or >

" show tab symbols
" set list
" listchars=tab:▸\ ,eol:¬

" jump to tabs directly
" inoremap <a-1> 1gt
" nnoremap <a-1> 1gt
" inoremap <a-2> 2gt
" nnoremap <a-2> 2gt
" inoremap <a-3> 3gt
" nnoremap <a-3> 3gt

" indent
ca 2et setlocal ts=2 sts=2 sw=2 et
ca 2noet setlocal ts=2 sts=2 sw=2 noet
ca 4et setlocal ts=4 sts=4 sw=4 et
ca 4noet setlocal ts=4 sts=4 sw=4 noet
ca cc80 sw=4 ts=4 sts=4 et nowrap linebreak nolist tw=76 cc=80

" nnoremap <f1> :set sw=4 ts=4 sts=4 et nowrap linebreak nolist tw=76 cc=80<CR>
" " nnoremap <f1> :set sw=4 ts=4 sts=4 et<cr>
" nnoremap <f2> :set sw=2 ts=2 sts=2 et<cr>
" nnoremap <f3> :set sw=2 ts=2 sts=2 noet<cr>
" nnoremap <f4> :set sw=4 ts=4 sts=4 et<cr>
" nnoremap <f5> :set sw=4 ts=4 sts=4 noet<cr>
" nnoremap <f6> :set fo=tcqbl<cr>

" http://stackoverflow.com/questions/3033423/vim-command-to-restructure-force-text-to-80-columns
nnoremap <f6> gg gqG<cr>

" Move tabs left/right http://stackoverflow.com/a/7192324/195139
nnoremap <silent> <s-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <s-right> :execute 'silent! tabmove ' . tabpagenr()<cr>

" duplicate current tab
nnoremap <c-y> :tabnew %<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CamelCaseMotion
map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

omap iw <Plug>CamelCaseMotion_iw
xmap iw <Plug>CamelCaseMotion_iw
omap ib <Plug>CamelCaseMotion_ib
xmap ib <Plug>CamelCaseMotion_ib
omap ie <Plug>CamelCaseMotion_ie
xmap ie <Plug>CamelCaseMotion_ie

" AutoTag
if filereadable("~/.vim/bundle/AutoTag/plugin/autotag.vim")
    source ~/.vim/bundle/AutoTag/plugin/autotag.vim
endif

" BufExplorer
nnoremap <leader>be :tabnew \| BufExplorer<cr>
ca be tabnew \| BufExplorer
ca bs BufExplorerHorizontalSplit
ca bv BufExplorerVerticalSplit

" CtrlP
let g:ctrlp_map = '<s-t>'
nnoremap <c-b> = :CtrlPBuffer<cr>
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_lazy_update = 0
let g:ctrlp_use_caching = 1000
let g:ctrlp_cache_dir = '~/.vim/tmp/ctrlp'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 50000
let g:ctrlp_max_height = 20
let g:ctrlp_open_multiple_files = 'tj'
" make tabs default behavior
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-b>'],
    \ 'AcceptSelection("t")': ['<cr>', '<c-t>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-s>', '<c-x>'],
    \ }
set wildignore+=build/**
set wildignore+=htdocs/**

" CSApprox
let g:CSApprox_verbose_level = 0

" EasyMotion
" let g:EasyMotion_keys = 'sadfjklewcmpghSADFJKLEWCMPGH'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
nnoremap f H:call EasyMotion#WB(0, 0)<cr>

" gitsessions.vim
let g:gitsessions_dir = 'tmp/sessions'
nnoremap <leader>ss :GitSessionSave<cr>
nnoremap <leader>ls :GitSessionLoad<cr>
nnoremap <leader>ds :GitSessionDelete<cr>

" Gundo
ca gdt GundoToggle

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" NERD Commentor
let g:NERDSpaceDelims = 1

" NERD Tree
let NERDTreeShowHidden = 1
nnoremap <leader>nt :NERDTreeToggle
ca nt NERDTreeToggle

" Powerline
if isdirectory('~/.vim/bundle/powerline/powerline/bindings/vim')
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
endif
let g:Powerline_symbols = 'compatible'
" let g:Powerline_symbols = 'fancy'

" Rainbow Parentheses
ca rbt RainbowParenthesesToggle
ca rbta RainbowParenthesesToggleAll
let g:rbpt_colorpairs = [
    \ ['3',         '808000'],
    \ ['6',         '008080'],
    \ ['202',       'ff5f00'],
    \ ['11',        'ffff00'],
    \ ['13',        'ff00ff'],
    \ ['10',        '00ff00'],
    \ ['45',        '00dfff'],
    \ ['9',         'ff0000'],
    \ ]

augroup RainbowParentheses
    au!
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
augroup END

" Switch
" nnoremap 0 :Switch<cr>
let g:switch_custom_definitions =
    \ [
    \   ['True', 'False']
    \ ]

" Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_warnings = 1
" let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
ca st SyntasticToggleMode
ca sc SyntasticCheck

" UltiSnips
ca use UltiSnipsEdit
let g:UltiSnipsDontReverseSearchPath = "1"        " workaround Vundle
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" vim-fugitive
ca ge Gedit origin/master:%
ca gt Gtabedit origin/master:%
ca gs Gsplit origin/master:%
ca gv Gvsplit origin/master:%

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" YankStack
" let g:yankstack_map_keys = 0
" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Work
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! WorkSettings()
    set wildignore+=build/**
    set wildignore+=htdocs/**
    ca ge Gedit canon/master:%
    ca gt Gtabedit canon/master:%
    ca gs Gsplit canon/master:%
    ca gv Gvsplit canon/master:%
endfunction

" FIXME: make it conditional only for work (2013.06.13_1038, wting)
let g:syntastic_mode_map = {
                            \ 'mode': 'active',
                            \ 'passive_filetypes': ['python']
                            \ }

" let g:syntastic_ignore_files=['^/home/wting/work/']
augroup vimrc-work
    au BufNewFile,BufRead ~/pg/* call WorkSettings()
    au BufNewFile,BufRead ~/pg/*.py setlocal sw=4 ts=4 sts=4 noet
    au BufNewFile,BufRead ~/pg/*.tmpl setlocal sw=2 ts=2 sts=2 noet
augroup END
