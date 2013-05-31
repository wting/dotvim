" io at williamting.com
" https://github.com/wting/dotvim
"
" Sections:
"    -> Plugins
"    -> Vundle Configuration
"    -> GVIM Specific Options
"    -> General
"    -> VIM User Interface
"    -> Colors and Fonts
"    -> Files and Backups
"    -> Text, Tab and Indent Related
"    -> Insert Mode Related
"    -> Visual Mode Related
"    -> Command Mode Related
"    -> Moving Around, Tabs and Buffers
"    -> Statusline
"    -> Parenthesis/Bracket Expanding
"    -> General Abbrevs
"    -> Editing Mappings
"    -> Session Management
"    -> Plugin Options

set nocompatible
filetype on				"disable OS X exit with non-zero error code
filetype off			"disabled to work around vundle ftdetect bug

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVIM Specific Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

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

Bundle 'gmarik/vundle'

" Look & Feel
Bundle 'vim-scripts/CSApprox'
Bundle 'guns/xterm-color-table.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'kshenoy/vim-signature'
Bundle 'airblade/vim-gitgutter'

" Powerline and dependencies
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/powerline'

" Add Additional Features
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'camelcasemotion'
" Bundle 'scrooloose/nerdcommenter'
Bundle 'wting/nerdcommenter'
" Bundle 'embear/vim-localvimrc'
Bundle 'bufexplorer.zip'
Bundle 'wting/gitsessions.vim'

Bundle 'wincent/Command-T'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'brookhong/cscope.vim'
Bundle 'vim-scripts/AutoTag'

" Syntax
Bundle 'wting/rust.vim'
Bundle 'scrooloose/syntastic'
Bundle 'plasticboy/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'vim-scripts/haskell.vim'
Bundle 'kchmck/vim-coffee-script'

" non github, git repos
"Bundle 'git://git.wincent.com/command-t.git'

filetype plugin on
filetype plugin indent on

set ofu=syntaxcomplete#Complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVIM Specific Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set vb t_vb=
set guioptions-=T

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000
set undolevels=1000

set title                				"change the terminal's title
set backspace=indent,eol,start 			"allow bs over everything
set iskeyword=@,48-57,_,192-255

set modelines=0							"remove modelines, prevents a few security exploits
set hidden

ca waq wqa
ca 2et setlocal ts=2 sts=2 sw=2 et
ca 2noet setlocal ts=2 sts=2 sw=2 noet
ca 4et setlocal ts=4 sts=4 sw=4 et
ca 4noet setlocal ts=4 sts=4 sw=4 noet

ca vv :vs $MYVIMRC<cr>
ca va :vs ~/custom/aliases<cr>
ca vg :vs ~/.gitconfig<cr>
ca rfv so $MYVIMRC
" automatically reload vimrc when it's saved
" au BufWritePost .vimrc so $MYVIMRC

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number								"show line numbers
set nowrap								"no word wrapping
set formatoptions=qrn1

if exists("&relativenumber")
    set relativenumber					"show line number relative to cursor
    silent! au InsertEnter * :set number
    silent! au InsertLeave * :set relativenumber
    silent! au FocusLost * :set number
    silent! au FocusGained * :set relativenumber
endif

set ttyfast
set ruler
set visualbell           				"don't beep
set noerrorbells         				"don't beep
set showmode
set showcmd

set scrolloff=4							"minimal number of screen lines to keep above and below the cursor.

set splitright
set splitbelow

" ca sb sb
" Open a vertical split buffer by number
ca vb vert sb

"set winminheight=5

"automatically resize vertical splits.
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

"rebind to modify window heights
if bufwinnr(1)
  nnoremap + <C-W>+
  nnoremap - <C-W>-
endif

"set folds, default open
set foldmethod=indent
set foldlevel=20
set foldlevelstart=20
set showtabline=2

"fold tags (for html)
nnoremap <leader>hft Vatzf
"sort CSS properties
nnoremap <leader>hcss ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

"note, perl automatically sets foldmethod in the syntax file
" au Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
" au Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"make saving and loading folds automatic
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"highlights trailing whitespace
"syntax on
syntax enable
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
au Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"remove trailing whitespace
"au BufWritePre * :%s/\s\+$//e
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
au BufWritePre * :call StripTrailingWhitespaces()

"show tabs and carriage returns, unnecessary because of indent guides plugin
"set list
"listchars=tab:▸\ ,eol:¬

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
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256							"force 256 color support even if terminal doesn't allow it
set cursorline							"shows the current line in different color

" let g:zenburn_high_Contrast = 1
" let g:zenburn_force_dark_Background = 1
" let g:zenburn_unified_CursorColumn = 1
colorscheme zenburn

" autocmd ColorScheme * hi CursorLine term=underline ctermfg=white ctermbg=24 gui=bold guibg=#121212
" autocmd ColorScheme * hi CursorLine term=underline ctermfg=white ctermbg=darkblue gui=bold guibg=#121212

set background=dark                     " dark tab display

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set enc=utf-8
set fenc=utf-8
set nobackup
set wildmenu
set wildmode=list:longest
set wildignore+=*.DS_Store							" OSX bullshit
set wildignore+=.hg,.git,.svn						" Version control
set wildignore+=*.sw?,*.un?							" vim
set wildignore+=*.aux,*.out,*.toc					" LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg		" binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest	" compiled object files
set wildignore+=*.spl								" compiled spelling word lists
set wildignore+=*.class								" Java
set wildignore+=*.pyc								" Python

" Yelp
set wildignore+=build/**
set wildignore+=htdocs/**

set tags=./tags;/

silent !mkdir -p ~/.vim/tmp/backup >/dev/null 2>&1
set backupdir=~/.vim/tmp/backup						" backups
set backup											" enable backups

silent !mkdir -p ~/.vim/tmp/swap >/dev/null 2>&1
set directory=~/.vim/tmp/swap						" swap files
set noswapfile										" It's 2013, Vim.

if has("persistent_undo")
    silent !mkdir -p ~/.vim/tmp/undo >/dev/null 2>&1
    set undodir=~/.vim/tmp/undo
    set undofile
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab and Indent Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set tabstop=4
set shiftwidth=4
set shiftround 							"use multiples of shiftwidth when using < or >

nnoremap <f1> :set sw=4 ts=4 sts=4 et wrap linebreak nolist tw=76 cc=80<CR>
nnoremap <f2> :set sw=2 ts=2 sts=2 et<CR>
nnoremap <f3> :set sw=2 ts=2 sts=2 noet<CR>
nnoremap <f4> :set sw=4 ts=4 sts=4 et<CR>
nnoremap <f5> :set sw=4 ts=4 sts=4 noet<CR>
nnoremap <f6> :set fo=tcqbl<CR>
" http://stackoverflow.com/questions/3033423/vim-command-to-restructure-force-text-to-80-columns
nnoremap <f6> gg gqG<CR>

ca t2s :%s/\t/    / | noh
ca s2t :%s/    /\t/ | noh

ca "2' :s/"/'/ | noh
ca '2" :s/'/"/ | noh

"Move tabs left/right http://stackoverflow.com/a/7192324/195139
nnoremap <silent> <S-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <S-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Add / Subtract Operator Spacing
nnoremap <leader>aos :s/\v([+-/*=])/ \1 /<cr> :noh<cr>
nnoremap <leader>sos :s/\v ([+-/*=]) /\1/<cr> :noh<cr>
ca add_op_space s/\v([+-/*=])/ \1 /
ca sub_op_space s/\v ([+-/*=]) /\1/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert Mode Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fix slight delay after pressing ESC then O
" http://ksjoberg.com/vim-esckeys.html
" set noesckeys
set timeout timeoutlen=1000 ttimeoutlen=100

inoremap <c-d> <esc>ddi
inoremap <c-u> <esc>gUiwi


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Mode Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't use Ex mode
nnoremap Q gqG

"allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command Mode Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"reduce keystrokes for command mode
inoremap ;w <esc>:w<cr>a
nnoremap ; :

"return cursor after using . command
nmap . .`[

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving Around, Tabs and Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"arrow keys move between buffers / tabs
inoremap <silent> <Up> <esc>:bprev<cr>
inoremap <silent> <Down> <esc>:bnext<cr>
inoremap <silent> <Left> <esc>:tabprev<cr>
inoremap <silent> <Right> <esc>:tabnext<cr>
noremap <silent> <Up> :bprev<cr>
noremap <silent> <Down> :bnext<cr>
noremap <silent> <Left> :tabprev<cr>
noremap <silent> <Right> :tabnext<cr>

"easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"search options
set ignorecase
set smartcase							"disable ignore case if uppercase present
set gdefault
set incsearch
set hlsearch
set showmatch
"redraw screen and remove search highlights
nnoremap <silent> <c-l> :noh<cr><c-l>
nnoremap <silent> = :noh<cr>
"disable vim regex, use Perl/Python regex instead
nnoremap / /\v
vnoremap / /\v

"change default grep behavior
set grepprg=gp\ -n

"navigate wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

nmap <S-k> <C-b>
nmap <space> <C-f>
nmap n nzz
nmap N Nzz

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%<%y\ b%n\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/Bracket Expanding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"exit insert mode alternatives
inoremap jj <esc>j
cnoremap jj <C-c>j
inoremap kk <esc>k
cnoremap kk <C-c>k
nnoremap H ^
nnoremap L $
inoremap ZZ <esc>:wq<Cr>

"Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

"forgot sudo?
cmap w!! w !sudo tee % >/dev/null

"toggle line numbers
nnoremap <C-N><C-N> :set invnumber<CR>

let mapleader=","

nnoremap <C-\><C-\> :vs <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-\> :sp <CR>:exec("tag ".expand("<cword>"))<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"manipulate text using alt + hjkl
nnoremap <A-j> :m+<cr>==
nnoremap <A-k> :m-2<cr>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<cr>==gi
inoremap <A-k> <Esc>:m-2<cr>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-j> :m'>+<cr>gv=gv
vnoremap <A-k> :m-2<cr>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

"adding / removing lines
map <S-Enter> O<CR><Esc>
map <CR> o<Esc>

" yank and paste from system register / clipboard
vnoremap <C-Y><C-Y> "+y
nnoremap <C-P><C-P> "+p
ca p set paste
ca np set nopaste

"toggle paste option
"nnoremap <C-P><C-P> :set invpaste paste?<cr>

"automatically indent after pasting, use <leader>p to use regular paste
"nnoremap <leader>p p
"nnoremap <leader>P P
"nnoremap p p'[v']=
"nnoremap P P'[v']=

"make Y behave like other capitals
map Y y$

ca w' w
ca w" w

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session Management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitsessions_dir = 'tmp/sessions'

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
" Plugin Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"CamelCaseMotion
"remap default keys
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

"AutoTag
if filereadable("~/.vim/bundle/AutoTag/plugin/autotag.vim")
	source ~/.vim/bundle/AutoTag/plugin/autotag.vim
endif

"Command-T
let g:CommandTScanDotDirectories = 0
" nnoremap <S-T> :exec 'CommandTFlush' <Bar> CommandT<CR>
nnoremap <S-T> :CommandT<CR>
nnoremap <silent> <leader>t :CommandT<CR>
nnoremap <silent> <leader>b :CommandTBuffer<CR>
"change default behavior to open in new tab
let g:CommandTAcceptSelectionTabMap = ['<CR>', '<C-t>']
let g:CommandTAcceptSelectionSplitMap = ['<C-\>']
let g:CommandTAcceptSelectionVSplitMap = ['<C-v>']

"CSApprox
let g:CSApprox_verbose_level = 0

"Gundo
" nnoremap <leader>gdt :GundoToggle<CR>
ca gdt GundoToggle

"Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

"localvimrc
let g:localvimrc_ask = 0

"NERD commentor
let g:NERDSpaceDelims = 1

"NERD Tree
ca nt NERDTreeToggle

"Powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'

"Rainbow Parentheses, causes problems with markdown files
ca rbt RainbowParenthesesToggle
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare					"bug: triggers on _
"au Syntax * RainbowParenthesesLoadBraces

" Sessions
let g:session_autosave = 0

"Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_quiet_warnings = 1

"UltiSnips
ca use UltiSnipsEdit
let g:UltiSnipsDontReverseSearchPath = "1"					"vundle messing up search order
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:vim_markdown_folding_disabled=1

"make sign column same color as theme
"highlight clear SignColumn
hi! link SignColumn LineNr
