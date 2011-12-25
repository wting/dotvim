" Customized by: william.h.ting at gmail.com
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings
"
" Plugins_Included:
"
"     > Command-T - http://www.vim.org/scripts/script.php?script_id=3025
"     "       Command-T plug-in provides an extremely fast, intuitive
"     mechanism for opening filesa:
"     "           info -> :help CommandT
"     "           screencast and web-help -> http://amix.dk/blog/post/19501
"     "
set nocompatible
set enc=utf-8
set fenc=utf-8
set number
set backspace=indent,eol,start "allow bs over everything
"fixdel "for Cygwin
set nobackup
"set noswapfile
"set dir=/tmp "swap file location

set autoindent
set smartindent
set iskeyword=@,48-57,_,192-255
set tabstop=4
set shiftwidth=4
set shiftround "use multiples of shiftwidth when using < or >
"set expandtab "use spaces instead of \t
set nowrap
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set showmode

set splitright
set splitbelow

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=4

" Shows the current line in different color
set cursorline

" Colorschemes
set t_Co=256			" force 256 color support even if terminal doesn't allow it
colorscheme zenburn
set background=dark

filetype plugin on
syntax on
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"remove trailing whitespace
"http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
autocmd BufWritePre * :%s/\s\+$//e
"autocmd BufWritePre *.c :%s/\s\+$//e
"autocmd BufWritePre *.cpp :%s/\s\+$//e
"autocmd BufWritePre *.css :%s/\s\+$//e
"autocmd BufWritePre *.c++ :%s/\s\+$//e
"autocmd BufWritePre *.h :%s/\s\+$//e
"autocmd BufWritePre *.html :%s/\s\+$//e
"autocmd BufWritePre *.java :%s/\s\+$//e
"autocmd BufWritePre *.js :%s/\s\+$//e
"autocmd BufWritePre *.php :%s/\s\+$//e
"autocmd BufWritePre *.pl :%s/\s\+$//e
"autocmd BufWritePre *.py :%s/\s\+$//e
"autocmd BufWritePre *.sql :%s/\s\+$//e
"autocmd BufWritePre *.wiki :%s/\s\+$//e
"autocmd FileType c,cpp,c++,java,php,pl,py autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"search options
set smartcase "ignore case if all lowercase
set ignorecase
set incsearch
set hlsearch
set showmatch

nmap <space> <C-f>
nmap n nzz
nmap N Nzz

"adding / removing lines
map <S-Enter> O<Esc>
map <CR> o<Esc>

"reduce keystrokes for command mode
inoremap ;w <esc>:w<cr>a
nnoremap ; :

"set arrow keys to move between buffer / tabs
inoremap <Up> <esc>:bprev<cr>
inoremap <Down> <esc>:bnext<cr>
inoremap <Left> <esc>:tabprev<cr>
inoremap <Right> <esc>:tabnext<cr>
noremap <Up> :bprev<cr>
noremap <Down> :bnext<cr>
noremap <Left> :tabprev<cr>
noremap <Right> :tabnext<cr>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Maps for jj to act as esc
inoremap jj <esc>j
cnoremap jj <C-c>j
inoremap kk <esc>k
cnoremap kk <C-c>k

inoremap ZZ <esc>:wq<Cr>

"Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

"navigate wrapped lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

"forget sudo
cmap w!! w !sudo tee % >/dev/null

"toggle paste option
nnoremap <C-P><C-P> :set invpaste paste?<CR>

"toggle line numbers
nnoremap <C-N><C-N> :set invnumber<CR>

"gvim specific options
set vb t_vb=
set guioptions-=T

"http://vim.wikia.com/wiki/All_folds_open_when_open_a_file
"Set folds, default open
set foldmethod=indent
set foldlevel=20
set foldlevelstart=20
set showtabline=2

" Vertical Split Buffer Function
"function VerticalSplitBuffer(buffer)
	"execute "vert belowright sb" a:buffer
	"endfunction

" Vertical Split Buffer Mapping
"command -nargs=1 Vbuffer call VerticalSplitBuffer(<f-args>)

" Automatically resize vertical splits.
:au WinEnter * :set winfixheight
:au WinEnter * :wincmd =

" Note, perl automatically sets foldmethod in the syntax file
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"Make saving and loading folds automatic
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

"plugin command t
noremap <S-T> :CommandT<cr>
"change default behavior to open in new tab
let g:CommandTAcceptSelectionTabMap=['<CR>']
set wildignore+=*.o,*.obj,.git,*.pyc,*.png,*.jpg,*.gif

"always show status line
set laststatus=2
set statusline=%<%y\ b%n\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"\ %{SyntasticStatuslineFlag()}
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

"for Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

"for indent guides plugin
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" indent guides without using above plugin
" set list
" set listchars=tab:→\

"for Gundo
nnoremap <F5> :GundoToggle<CR>

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

au BufWritePost ~/.vimrc source ~/.vimrc
