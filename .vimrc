" io at williamting.com
" https://github.com/wting/dotvim
"
" Sections:
"    -> Vundle Configuration
"    -> Plugins
"    -> General Settings
"    -> GVIM
"    -> Statusline
"    -> Colors and Fonts
"    -> Files
"    -> Session Management
"    -> General Abbrevs
"    -> Mappings
"    -> Text, Tab and Indent
"    -> Insert Mode
"    -> Visual Mode
"    -> Command Mode
"    -> Moving Around
"    -> Plugin Options

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

" Features
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'camelcasemotion'
" Bundle 'scrooloose/nerdcommenter'
Bundle 'wting/nerdcommenter'
" Bundle 'embear/vim-localvimrc'
Bundle 'bufexplorer.zip'
" Bundle 'wting/gitsessions.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'AndrewRadev/switch.vim'
Bundle 'sjl/gundo.vim'

Bundle 'brookhong/cscope.vim'
Bundle 'vim-scripts/AutoTag'

" Powerline
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
" Bundle 'Lokaltog/powerline'

" Appearance
Bundle 'vim-scripts/CSApprox'
Bundle 'guns/xterm-color-table.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'kshenoy/vim-signature'
Bundle 'airblade/vim-gitgutter'

" Syntax
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

set number
if exists("&relativenumber")
    set relativenumber
    silent! au InsertEnter * :set number
    silent! au InsertLeave * :set relativenumber
    silent! au FocusLost * :set number
    silent! au FocusGained * :set relativenumber
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
call yankstack#setup()

" automatically resize vertical splits.
au WinEnter * set winfixheight
au WinEnter * wincmd =

" fix slight delay after pressing ESC then O: http://ksjoberg.com/vim-esckeys.html
" set noesckeys
set timeout timeoutlen=1000 ttimeoutlen=100

" set folds, default open
set foldmethod=indent
set foldlevel=20
set foldlevelstart=20
set showtabline=2

" auto save/load folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

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
au BufWritePre * :call StripTrailingWhitespaces()

" TODO: check that it works (2013.06.06_2225, ting)
" http://vim.wikia.com/wiki/Cscope
" if has('cscope')
    " set cscopetag cscopeverbose

    " if has('quickfix')
        " set cscopequickfix=s-,c-,d-,i-,t-,e-
    " endif

    " cnoreabbrev csa cs add
    " cnoreabbrev csf cs find
    " cnoreabbrev csk cs kill
    " cnoreabbrev csr cs reset
    " cnoreabbrev css cs show
    " cnoreabbrev csh cs help

    " command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
" endif


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256							"force 256 color support even if terminal doesn't allow it
set cursorline							"shows the current line in different color

" let g:zenburn_high_Contrast = 1
" let g:zenburn_force_dark_Background = 1
" let g:zenburn_unified_CursorColumn = 1
colorscheme zenburn

autocmd ColorScheme * hi CursorLine term=underline ctermbg=darkblue

set background=dark                     " dark tab display for indent guides

"make sign column same color as theme
"highlight clear SignColumn
hi! link SignColumn LineNr


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set wildignore+=*.pyc                                       " Python
set wildignore+=*/tmp/*,*.so,*.zip

" Yelp
set wildignore+=build/**
set wildignore+=htdocs/**

set tags=./tags;/

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session Management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Trim(string)
    return substitute(substitute(a:string, '^\s*\(.\{-}\)\s*$', '\1', ''), '\n', '', '')
endfunction

function! GitBranchName()
    return Trim((system("git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //'")))
endfunction

function! MySessionDir()
    let l:dir = $HOME . '/.vim/sessions' . getcwd()
    if (filewritable(l:dir) != 2)
        exe 'silent !mkdir -p ' l:dir
        redraw!
    endif
    return l:dir
endfunction

function! MySessionFile()
    let l:branch = GitBranchName()
    if empty(l:branch)
        return MySessionDir() . '/master.vim'
    endif
    return MySessionDir() . '/' . l:branch
endfunction

function! MySaveSession()
    let l:sessiondir = MySessionDir()
    let l:sessionfile = MySessionFile()
    exe "mksession! " . l:sessionfile
    echom "session created: " . l:sessionfile
endfunction

function! MyUpdateSession()
    let l:sessiondir = MySessionDir()
    let l:sessionfile = MySessionFile()
    if (filereadable(l:sessionfile))
        exe "mksession! " . l:sessionfile
        echom "session updated: " . l:sessionfile
    endif
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

command MSS call MySaveSession()
command MLS call MyLoadSession()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
ca vhe vert help
ca waq wqa
ca nw set nowrap

ca vv :vs $MYVIMRC<cr>
ca va :vs ~/custom/aliases<cr>
ca vg :vs ~/.gitconfig<cr>
ca rfv so $MYVIMRC

" paste
ca p set paste
ca np set nopaste

" indent
ca 2et setlocal ts=2 sts=2 sw=2 et
ca 2noet setlocal ts=2 sts=2 sw=2 noet
ca 4et setlocal ts=4 sts=4 sw=4 et
ca 4noet setlocal ts=4 sts=4 sw=4 noet

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
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

"rebind to modify window heights
if bufwinnr(1)
    nnoremap + <c-w>+
    nnoremap - <c-w>-
endif

"exit insert mode alternatives
inoremap jj <esc>j
cnoremap jj <C-c>j
inoremap kk <esc>k
cnoremap kk <C-c>k
nnoremap H ^
nnoremap L $
inoremap ZZ <esc>:wq<cr>
nnoremap ZA :wqa<cr>

"Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

"forgot sudo?
cmap w!! w !sudo tee % >/dev/null

"toggle line numbers
nnoremap <C-N><C-N> :set invnumber<CR>

nnoremap <c-\><c-\> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <c-\> :sp <cr>:exec("tag ".expand("<cword>"))<cr>
nnoremap <c-y> :tabnew %<cr>

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

nnoremap <f1> :set sw=4 ts=4 sts=4 et nowrap linebreak nolist tw=76 cc=80<CR>
" nnoremap <f1> :set sw=4 ts=4 sts=4 et<cr>
nnoremap <f2> :set sw=2 ts=2 sts=2 et<cr>
nnoremap <f3> :set sw=2 ts=2 sts=2 noet<cr>
nnoremap <f4> :set sw=4 ts=4 sts=4 et<cr>
nnoremap <f5> :set sw=4 ts=4 sts=4 noet<cr>
nnoremap <f6> :set fo=tcqbl<cr>
" http://stackoverflow.com/questions/3033423/vim-command-to-restructure-force-text-to-80-columns
nnoremap <f6> gg gqG<cr>

" Move tabs left/right http://stackoverflow.com/a/7192324/195139
nnoremap <silent> <s-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<cr>
nnoremap <silent> <s-right> :execute 'silent! tabmove ' . tabpagenr()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-d> <esc>ddi
inoremap <c-u> <esc>gUiwi


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't use Ex mode
nnoremap Q gqG

"allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command Mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" reduce keystrokes for command mode
inoremap ;w <esc>:w<cr>a
nnoremap ; :

" return cursor after using . command
nmap . .`[


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving Around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" arrow keys move between buffers / tabs
inoremap <silent> <up> <esc>:bprev<cr>
inoremap <silent> <down> <esc>:bnext<cr>
inoremap <silent> <left> <esc>:tabprev<cr>
inoremap <silent> <right> <esc>:tabnext<cr>
noremap <silent> <up> :bprev<cr>
noremap <silent> <down> :bnext<cr>
noremap <silent> <left> :tabprev<cr>
noremap <silent> <right> :tabnext<cr>

" easy window navigation
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" redraw screen and remove search highlights
nnoremap <silent> = :noh<cr>

" navigate wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

nmap <s-k> <pageup>
nmap <space> <pagedown>
nmap n nzz
nmap N Nzz


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

" CtrlP
let g:ctrlp_map = '<s-t>'
nnoremap <c-b> = :CtrlPBuffer<cr>
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = '~/.vim/tmp/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 0
let g:ctrlp_max_files = 0
let g:ctrlp_max_height = 20
" make tabs default behavior
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" CSApprox
let g:CSApprox_verbose_level = 0

" gitsessions.vim
let g:gitsessions_dir = 'tmp/sessions'

" Gundo
ca gdt GundoToggle

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" localvimrc
let g:localvimrc_ask = 0

" NERD commentor
let g:NERDSpaceDelims = 1

" Powerline
if isdirectory('~/.vim/bundle/powerline/powerline/bindings/vim')
    set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
endif
" let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols = 'fancy'

" Rainbow Parentheses
" FIXME: enable on enter (2013.06.06_2307, ting)
ca rbt RainbowParenthesesToggle

" Sessions
let g:session_autosave = 0

" Switch
nnoremap 0 :Switch<cr>
let g:switch_custom_definitions =
    \ [
    \   ['True', 'False']
    \ ]

" Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_warnings = 1
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

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" YankStack
let g:yankstack_map_keys = 0
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
