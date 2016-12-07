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
"    -> ctags and cscope
"    -> Plugin Options
"    -> Work

set nocompatible
" disable OS X exit with non-zero error code
filetype on
" disabled to work around vundle ftdetect bug
filetype off


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Configuration
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Plugin 'gmarik/vundle'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Utilities
    " Plugin 'SirVer/ultisnips'
    Plugin 'wting/ultisnips'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'wellle/targets.vim'
    Plugin 'camelcasemotion'
    Plugin 'wting/nerdcommenter'
    Plugin 'wting/bufexplorer.vim'
    Plugin 'wting/gitsessions.vim'
    Plugin 'wting/pair_files.vim'
    Plugin 'kien/ctrlp.vim'
    Plugin 'FelikZ/ctrlp-py-matcher'
    Plugin 'sjl/gundo.vim'
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'majutsushi/tagbar'
    Plugin 'wting/vim-hackernews'
    " currently broken
    " Plugin 'Konfekt/FastFold'
    " Plugin 'xolox/vim-easytags'
    " Plugin 'xolox/vim-misc'

    " Powerline
    Plugin 'tpope/vim-fugitive'
    Plugin 'wting/vim-powerline'

    " Appearance
    Plugin 'vim-scripts/CSApprox'
    Plugin 'wting/rainbow_parentheses.vim'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'kshenoy/vim-signature'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'ap/vim-css-color'
    Plugin 'guns/xterm-color-table.vim'

    " Syntax
    Plugin 'scrooloose/syntastic'
    Plugin 'rust-lang/rust.vim'
    Plugin 'tpope/vim-markdown'
    Plugin 'groenewege/vim-less'
    Plugin 'elzr/vim-json'
    Plugin 'vim-scripts/haskell.vim'
    Plugin 'kchmck/vim-coffee-script'
    Plugin 'honza/dockerfile.vim'
    Plugin 'sophacles/vim-bundle-mako'
    Plugin 'dag/vim-fish'
    Plugin 'smerrill/vcl-vim-plugin'
    Plugin 'cespare/vim-toml'
    Plugin 'solarnz/thrift.vim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    filetype plugin on
    filetype plugin indent on
    syntax enable

    set ofu=syntaxcomplete#Complete
    set history=10000
    set undolevels=10000
    " multiple plugins are fucking with undolevels
    auto BufNewFile,BufRead * setlocal undolevels=10000
    " change the terminal's title
    set title
    " allow backspace over everything
    set backspace=indent,eol,start
    set iskeyword=@,48-57,_,192-255
    set lazyredraw
    " remove modelines, prevents a few security exploits
    set modelines=0
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
    " disable ignore case if uppercase present
    set smartcase
    set gdefault
    set incsearch
    set hlsearch
    set showmatch

    " use Perl/Python regex instead
    nnoremap / /\v
    vnoremap / /\v

    "change default grep behavior
    set grepprg=gp\ -n

    " automatically resize vertical splits.
    augroup vimrc-vertical_splits
        au WinEnter * set winfixheight
        au WinEnter * wincmd =
    augroup END

    " fix slight delay after pressing ESC then O:
    " http://ksjoberg.com/vim-esckeys.html
    " set noesckeys
    set timeout timeoutlen=1000 ttimeoutlen=100

    " set folds, default open
    set foldmethod=indent
    set foldlevel=20
    set foldlevelstart=20
    set showtabline=2
    au BufRead * normal zR

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

    " reduce timeout to 5ms (from default 60ms) for large file support
    let g:matchparen_insert_timeout=5

    " don't make backup for certain directories, allows crontab -e on osx
    set backupskip=/tmp/*,/private/tmp/*

    if v:version < 704
        autocmd VimEnter * echom "Outdated vim version: " . string(v:version)
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

    " highlight current line
    au ColorScheme * hi CursorLine term=underline ctermbg=darkblue

    colorscheme zenburn

    " dark tab display for indent guides
    set background=dark

    " see highlighted colors
    " :hi
    " :so $VIMRUNTIME/syntax/hitest.vim

    " hlsearch color
    hi! Search term=reverse ctermfg=255 ctermbg=130

    " make sign column same color as theme
    hi! link SignColumn LineNr

    " highlight current word under cursor
    autocmd CursorMoved * silent! exe printf('match CursorLine  /\V\<%s\>/', escape(expand('<cword>'), '/\'))


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " autoreload vimrc on write
    " au BufWritePost .vimrc so $MYVIMRC
    set enc=utf-8
    set fenc=utf-8
    set nobackup
    set wildmenu
    set wildmode=list:longest

    " OSX bullshit
    set wildignore+=*.DS_Store
    " Version control
    set wildignore+=.hg,.git,.svn
    " vim
    set wildignore+=*.sw?,*.un?
    " images
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
    " object files
    set wildignore+=*.o,*.obj,*.so,*.a
    " Haskell
    set wildignore+=*.hi
    " Java
    set wildignore+=*.class
    " LaTeX
    set wildignore+=*.aux,*.out,*.toc
    " Python
    set wildignore+=.tox,*.pyc,*.pyo
    " Windows
    set wildignore+=*.exe,*.dll,*.manifest,*.spl
    " misc
    set wildignore+=*/tmp/**,*.zip

    " This results in duplicate tag entries when searching.
    " set tags=./tags;/

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

    " misc
    ca ln lnext
    command! PrettyJSON set ft=json | :%!python -m json.tool
    " requires libxml2-utils
    command! PrettyXML set ft=xml | :%!XMLLINT_INDENT='    ' xmllint --format --recover -

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving Around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " arrow keys allowed
    inoremap <silent> <left> <esc>:tabprev<cr>
    inoremap <silent> <right> <esc>:tabnext<cr>
    noremap <silent> <left> :tabprev<cr>
    noremap <silent> <right> :tabnext<cr>

    " move between tabs
    inoremap <silent> <c-h> <esc>:tabprev<cr>
    noremap <silent> <c-h> :tabprev<cr>
    inoremap <silent> <c-l> <esc>:tabnext<cr>
    noremap <silent> <c-l> :tabnext<cr>

    " move between windows
    nmap <c-n> <c-w>w
    nmap <c-p> <c-w>W

    " redraw screen and remove search highlights
    nnoremap <silent> = :noh<cr>

    " navigate wrapped lines as if they're real lines
    nnoremap k gk
    nnoremap j gj
    nnoremap gk k
    nnoremap gj j

    " use real lines instead of wrapped lines when jumping vertically
    nnoremap <expr> k (v:count ? 'k' : 'gk')
    nnoremap <expr> j (v:count ? 'j' : 'gj')

    " general movement
    nmap <s-k> <pageup>
    nmap <space> <pagedown>
    nmap n nzz
    nmap N Nzz
    nnoremap H ^
    nnoremap L $


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
    inoremap <c-u> <esc>gUiwi<esc>

    " insert lines above/below
    nnoremap <cr> o<esc>

    " make Y behave like other capitals
    map Y y$

    " yank and paste from system register / clipboard
    vnoremap <leader>y "+y
    " FIXME(ting|2016-07-27): vnoremap <leader>YY :%yank "+y
    vnoremap <leader>d "+d
    nnoremap <leader>p "+p
    nnoremap <leader>P "+P
    vnoremap <leader>p "+p
    vnoremap <leader>P "+P

    " ctrl-A to select all
    nnoremap <c-a> GVgg

    " yank / delete entire buffer
    nnoremap yY :%yank <c-r>=v:register<cr><cr>
    nnoremap dD :%delete <c-r>=v:register<cr><cr>

    " replace word under cursor in current buffer
    " http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
    nnoremap <leader>s :%s/\<<C-r><C-w>\>//<left>
    nnoremap <leader>r :call g:ReplaceCurrentWord('')<left><left>

    function! g:ReplaceCurrentWord(new_word)
        execute '%s/'.expand('<cword>') . '/' . a:new_word . '/'
        call feedkeys("\<c-o>")
    endfunction

    " Use space instead of C-y for tab suggestion completion
    inoremap <expr> <space> pumvisible() ? "\<c-y>" : " "


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab and Indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set autoindent
    set tabstop=4
    set shiftwidth=4
    " use multiples of shiftwidth when using < or >
    set shiftround

    " show tab symbols
    " set list
    " listchars=tab:▸\ ,eol:¬

    " jump to tabs directly
    nnoremap <leader>1 :tabnext 1<cr>
    nnoremap <leader>2 :tabnext 2<cr>
    nnoremap <leader>3 :tabnext 3<cr>
    nnoremap <leader>4 :tabnext 4<cr>
    nnoremap <leader>5 :tabnext 5<cr>
    nnoremap <leader>6 :tabnext 6<cr>
    nnoremap <leader>7 :tabnext 7<cr>
    nnoremap <leader>8 :tabnext 8<cr>
    nnoremap <leader>9 :tabnext 9<cr>
    nnoremap <leader>0 :tabnext 10<cr>

    " indent
    ca 2et setlocal ts=2 sts=2 sw=2 et
    ca 2noet setlocal ts=2 sts=2 sw=2 noet
    ca 4et setlocal ts=4 sts=4 sw=4 et
    ca 4noet setlocal ts=4 sts=4 sw=4 noet
    ca cc80 sw=4 ts=4 sts=4 et nowrap linebreak nolist tw=76 cc=80

    " Move tabs left/right
    if v:version >= 704
        nnoremap <silent> <s-left> :-tabmove<cr>
        nnoremap <silent> <s-right> :+tabmove<cr>
    else
        " NOTE(ting|2016-06-01): Only checked and working on Vim 7.03
        nnoremap <silent> <s-left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
        nnoremap <silent> <s-right> :execute 'silent! tabmove ' . tabpagenr()<CR>
    endif

    " duplicate current tab
    nnoremap <c-y> :tabnew %<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags and cscope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " open tag as split / vertical split / tab
    nnoremap <c-\> :sp <cr>:exec("tag ".expand("<cword>"))<cr>
    nnoremap <c-\><c-\> :vs <cr>:exec("tag ".expand("<cword>"))<cr>
    nnoremap <c-\><c-\><c-\> :tab split<cr>:exec("tag ".expand("<cword>"))<cr>

    " FIXME(wting|2013-06-06): setup cscope support
    " http://vim.wikia.com/wiki/Cscope
    " http://cscope.sourceforge.net/cscope_maps.vim
    " https://github.com/brookhong/cscope.vim/blob/master/plugin/cscope.vim
    if has('cscope')
        " always search cscope database in addition to tag files
        set cscopetag
        " prevents jumping to first tag
        set cscopeverbose
        " search cscope before ctags
        set csto=0
    endif


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
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_use_caching = 5000
    let g:ctrlp_cache_dir = '~/.vim/tmp/ctrlp'
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_max_files = 50000
    let g:ctrlp_max_height = 20
    let g:ctrlp_open_multiple_files = 'tj'
    " let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    " make tabs default behavior
    let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<c-b>'],
        \ 'AcceptSelection("t")': ['<cr>', '<c-t>', '<2-LeftMouse>'],
        \ 'AcceptSelection("h")': ['<c-s>', '<c-x>'],
        \ }
    " use external tools for finding files, faster for large directories
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s status -numac -I . $(hg root)'],
        \ },
        \ 'fallback': "find %s " .
            \ "-type f " .
            \ "-regextype posix-egrep " .
            \ "! -path './.hg/*' " .
            \ "! -path './.git/*' " .
            \ "! -path './.svn/*' " .
            \ "! -path './.tox/*' " .
            \ "! -path '*.egg-info*/*' " .
            \ "! -path '*.build.*' " .
            \ "! -path './venv*/*' " .
            \ "! -path './virtualenv*/*'"
        \ }

    " CSApprox
    let g:CSApprox_verbose_level = 0

    " EasyMotion
    let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
    nnoremap f H:call EasyMotion#WB(0, 0)<cr>

    " EasyTags
    let g:easytags_async = 1
    " use or create project specific tags file
    let g:easytags_dynamic_files = 2
    let g:easytags_file = '$HOME/.vim/tags'
    let g:easytags_events = ['BufWritePost']
    " very slow in large repos
    let g:easytags_autorecurse = 1
    let g:easytags_opts = ['--fields=+iaS --python-kinds=-i --sort=yes --extra=+q']

    " gitsessions.vim
    let g:gitsessions_dir = 'tmp/gitsessions'
    let g:gitsessions_use_cache = 1
    nnoremap <leader>ss :GitSessionSave<cr>
    nnoremap <leader>ls :GitSessionLoad<cr>
    nnoremap <leader>ds :GitSessionDelete<cr>

    " Gundo
    ca gdt GundoToggle

    " mergetool notes
    " http://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/
    " diffg RE " get from REMOTE
    " diffg BA " get from BASE
    " diffg LO " get from LOCAL

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
        \ ['3',         '#808000'],
        \ ['6',         '#008080'],
        \ ['202',       '#ff5f00'],
        \ ['11',        '#ffff00'],
        \ ['13',        '#ff00ff'],
        \ ['10',        '#00ff00'],
        \ ['45',        '#00dfff'],
        \ ['9',         '#ff0000'],
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
    let g:switch_custom_definitions = [
        \ ['True', 'False'] ]

    " Syntastic
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_enable_signs = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_error_symbol='⚠'
    let g:syntastic_warning_symbol = '∆'
    let g:syntastic_style_error_symbol = '✗'
    let g:syntastic_style_warning_symbol = '✗'
    let g:syntastic_haskell_ghc_mod_quiet_messages = {
        \ 'level': 'warnings',
        \ 'regex': 'Defined by not used', }
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_python_checkers = ['flake8']
    " let g:syntastic_python_flake8_args = '--config=$HOME/.config/flake8'
    let g:syntastic_python_flake8_args = '--max-line-length=131 --max-complexity=10'
    ca st SyntasticToggleMode
    ca sc SyntasticCheck

    " TagBar
    nnoremap <leader>tt :TagbarToggle<cr>

    " UltiSnips
    ca use UltiSnipsEdit
    " workaround Vundle
    let g:UltiSnipsDontReverseSearchPath = '1'
    let g:UltiSnipsSnippetDirectories = ['UltiSnips']
    let g:UltiSnipsEditSplit = 'horizontal'
    let g:UltiSnipsListSnippets = '<c-l>'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

    " vim-fugitive
    ca gb Gblame -w
    ca ge Gedit origin/master:%
    ca gt Gtabedit origin/master:%
    ca gs Gsplit origin/master:%
    ca gv Gvsplit origin/master:%

    " vim-markdown
    let g:vim_markdown_folding_disabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Work
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    function! WorkSettings()
        ca pfe PairFileEdit
        ca pfte PairFileTabEdit
        ca pfse PairFileSplitEdit
        ca pfve PairFileVSplitEdit
    endfunction

    augroup vimrc-work
        au BufNewFile,BufRead ~/pg/* call WorkSettings()
    augroup END

    " indent lines with single argument per line
    let @i = 't,llli'
    let @k = 't;llli'
    " indent lines with single argument per line for piped commands
    let @p = ':%s:\v\|:\r\|:'
