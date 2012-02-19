" Customized by: william.h.ting at gmail.com
"
" Sections:
"    -> Vundle Configuration
"    -> GVIM Specific Options
"    -> General
"    -> VIM User Interface
"    -> Colors and Fonts
"    -> Files and Backups
"    -> Text, Tab and Indent Related
"    -> Visual Mode Related
"    -> Command Mode Related
"    -> Moving Around, Tabs and Buffers
"    -> Statusline
"    -> Parenthesis/Bracket Expanding
"    -> General Abbrevs
"    -> Plugin Options

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
set nocompatible
filetype on								"disable OS X exit with non-zero error code
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" github repos
Bundle 'wincent/Command-T'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/syntastic'
"Bundle 'vim-scripts/vimwiki'
" vim-scripts repos
Bundle 'CSApprox'
Bundle 'localvimrc'
Bundle 'vimwiki'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number								"show line numbers
set nowrap								"no word wrapping

set visualbell           				"don't beep
set noerrorbells         				"don't beep
set showmode

set splitright
set splitbelow

set scrolloff=4							"minimal number of screen lines to keep above and below the cursor.
set cursorline							"shows the current line in different color

"automatically resize vertical splits.
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

"set folds, default open
set foldmethod=indent
set foldlevel=20
set foldlevelstart=20
set showtabline=2

"note, perl automatically sets foldmethod in the syntax file
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"make saving and loading folds automatic
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"highlights trailing whitespace
syntax on
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
"autocmd BufWritePre *.c :%s/\s\+$//e

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256							"force 256 color support even if terminal doesn't allow it
colorscheme zenburn
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set enc=utf-8
set fenc=utf-8
set wildignore=*.swp,*.bak,*.pyc,*.class
set nobackup

"http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	if has("folding")
		autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
	else
		autocmd BufWinEnter * call ResCur()
	endif
augroup END

if has("folding")
	function! UnfoldCur()
		if !&foldenable
			return
		endif
		let cl = line(".")
		if cl <= 1
			return
		endif
		let cf	= foldlevel(cl)
		let uf	= foldlevel(cl - 1)
		let min = (cf > uf ? uf : cf)
		if min
			execute "normal!" min . "zo"
			return 1
		endif
	endfunction
endif

au BufWritePost ~/.vimrc source ~/.vimrc "auto-reload .vimrc after saving

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab and Indent Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set shiftround 							"use multiples of shiftwidth when using < or >
"set expandtab 							"use spaces instead of tabs

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Mode Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
inoremap <Up> <esc>:bprev<cr>
inoremap <Down> <esc>:bnext<cr>
inoremap <Left> <esc>:tabprev<cr>
inoremap <Right> <esc>:tabnext<cr>
noremap <Up> :bprev<cr>
noremap <Down> :bnext<cr>
noremap <Left> :tabprev<cr>
noremap <Right> :tabnext<cr>

"easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"search options
set ignorecase
set smartcase							"ignore case if upper case present
set incsearch
set hlsearch
set showmatch

"navigate wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

nmap <space> <C-f>
nmap n nzz
nmap N Nzz

"adding / removing lines
map <S-Enter> O<Esc>
map <CR> o<Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%<%y\ b%n\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"\ %{SyntasticStatuslineFlag()}
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

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

inoremap ZZ <esc>:wq<Cr>

"Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

"forgot sudo?
cmap w!! w !sudo tee % >/dev/null

"toggle paste option
nnoremap <C-P><C-P> :set invpaste paste?<CR>

"toggle line numbers
nnoremap <C-N><C-N> :set invnumber<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Command-T
noremap <S-T> :CommandT<cr>
let g:CommandTAcceptSelectionTabMap=['<CR>']				"change default behavior to open in new tab
set wildignore+=*.o,*.obj,*.git,*.pyc,*.png,*.jpg,*.gif		"ignore certain files when searching

"CSApprox
let g:CSApprox_verbose_level = 0

"Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

"Indent guides without using plugin
"set list
"set listchars=tab:→\

"localvimrc
let g:localvimrc_ask=0

"Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
