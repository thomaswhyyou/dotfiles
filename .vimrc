" ==============================================================================
" NeoBundle
" ==============================================================================

set nocompatible
filetype off
let bundledir = expand('~/.vim/bundle')
let g:neobundle#install_process_timeout = 6000  "YouCompleteMe is slow

" Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
    " Install NeoBundle if not installed.
    if !isdirectory(bundledir.'/neobundle.vim')
        execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ bundledir.'/neobundle.vim'
    endif

    " Load neobundle.
    execute 'set runtimepath+='.bundledir.'/neobundle.vim'
endif


call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" For async vim process
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows' : 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'linux' : 'make',
    \     'unix' : 'gmake',
    \    },
    \ }

" Vim appearance
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'

" File browsing
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'henrik/vim-indexed-search'
NeoBundle 'moll/vim-bbye'
NeoBundle 'sjl/gundo.vim'

" Code intelligence
NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'ervandew/supertab'
NeoBundle 'Valloric/YouCompleteMe', {
     \ 'build' : {
     \     'mac' : './install.sh --clang-completer',
     \     'unix' : './install.sh --clang-completer',
     \     'windows' : './install.sh --clang-completer',
     \     'cygwin' : './install.sh --clang-completer'
     \    }
     \ }

" Version control
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-fugitive'

" Better maneuvering
NeoBundle 'terryma/vim-smooth-scroll'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'easymotion/vim-easymotion'

" Better editing
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'godlygeek/tabular'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Raimondi/delimitMate'

" Other utilities
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'nathanaelkane/vim-indent-guides'
" NeoBundle 'Shougo/vimshell.vim'


" ----
" Elixir
NeoBundle 'elixir-lang/vim-elixir'

" Python
NeoBundle 'sophacles/vim-bundle-mako'
" NeoBundle 'klen/python-mode'

" Markdown
NeoBundle 'tpope/vim-markdown'

" HTML
NeoBundle 'docunext/closetag.vim'
NeoBundle 'valloric/MatchTagAlways'

" JavaScript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'elzr/vim-json'

" Docker
NeoBundle 'ekalinin/Dockerfile.vim'


call neobundle#end()

filetype plugin indent on
NeoBundleClean
NeoBundleCheck



" ==============================================================================
" General Config
" ==============================================================================

" , and space as leader
let mapleader=','
:map <space> <leader>

" swap : vs ;
nnoremap : ;
nnoremap ; :

" prevent ghost characters? http://stackoverflow.com/a/6988748/3479934
set t_ku=OA
set t_kd=OB
set t_kr=OC
set t_kl=OD

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

set autoread                " auto read when a file is changed from outside
" http://stackoverflow.com/a/20418591/3479934
autocmd FocusGained,BufEnter * :silent! !
" Check timestamp more for 'autoread'
autocmd MyAutoCmd WinEnter * checktime

" yank and paste with the clipboard register '+', otherwise '*'
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" command waiting time & history
set ttimeout
set ttimeoutlen=30
set history=1000            " store lots of :cmdline history

" Platform detection
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin &&
      \ (has('mac') || has('macunix') || has('gui_macvim') || (!executable('xdg-open') && system('uname') =~? '^darwin'))

"Persistent undo settings
if has("persistent_undo")
    set undofile
    set undodir=~/.vim/undofiles/
    set undolevels=1000
    set undoreload=10000
endif

" completion sources
set complete-=i                     " http://stackoverflow.com/a/2460593/3479934
set infercase                       " Ignore case on insert completion.
" .: The current buffer
" w: Buffers in other windows
" b: Other loaded buffers
" u: Unloaded buffers
" t: Tags
" i: Included files

" unicode everything
set encoding=utf8
set termencoding=utf-8
set fileencoding=utf-8
set ffs=unix,dos,mac            " Use Unix as the standard file type

" no backup
set nobackup
set nowritebackup
set noswapfile

" define general regex for files and dirs we should ignore.
let general_ignore_pattern = [
    \ '\.swp', '\.swo', '\.tmp',
    \ '\.git', '\.hg', '\.svn', '\.gitkeep',
    \ '.*\.pyc', '\.ropeproject', '\.env-pypy',
    \ '.*\.egg', '.*\.egg-info',
    \ '\.zip', '\.tar\.gz', '\.tar\.bz2', '\.rar', '\.tar\.xz',
    \ '\.o', '\.out', '\.obj', '\.rbc', '\.rbo', '\.gem',
    \ '\.env', '\.env[0-9]',
    \ '\.coverage',
    \ '\.vagrant',
    \ '\.DS_Store',
    \ ]

" then those we should ignore in search.
let search_ignore_pattern = general_ignore_pattern + [
    \ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
    \ '\.mp3$', '\.mp4$',
    \ ]


" ==============================================================================
" User Interface
" ==============================================================================

" (Any change in colors must come after this section)
syntax on                   " enable syntax processing
set background=dark         " colorscheme
if isdirectory(bundledir.'/vim-colors-solarized')
    colorscheme solarized   " colorscheme
endif

set number                      " show line numbers..
set relativenumber              " ..mixed with relative numbers
set numberwidth=5               " give a bit more space for line numbers
set showcmd                     " show command in bottom bar

" cursor line highlighting
set cursorline                  " highlight current line
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal relativenumber
autocmd WinLeave * setlocal norelativenumber
highlight clear CursorLineNr
highlight CursorLineNr cterm=bold ctermfg=46 ctermbg=233
" highlight CursorLineNr cterm=bold ctermfg=148 ctermbg=233

set lazyredraw                  " redraw only when we need to
set ttyfast                     " fast redrawing
set showmatch                   " highlight matching [{()}]
set matchpairs+=<:>             " Highlight <>
set matchtime=2                 " how many tenths of a second to blink when matching brackets
set scrolloff=7                 " set 7 lines to the cursor - when moving vertically using j/k
set nostartofline               " don't move me around to the front automatically
set sidescrolloff=20            " set 20 cols to the cursor when moving horizontally
set colorcolumn=81              " line length marker
set laststatus=2                " always show statusline
set ruler                       " show where you are
set hidden                      " current buffer can be put into background "
set title                       " set terminal title "
set virtualedit=onemore         " allow one more character
set viewoptions="folds,options,cursor,unix,slash"     "unix/windows compatibility
set tildeop                     " Tilde acts as an operator
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" sane backspace
set backspace=2
set backspace=indent,eol,start

" visual autocomplete for command menu
set wildmenu
set wildmode=longest,list,full
set wildignore=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.env-pypy
set wildignore+=.git,.gitkeep
set wildignore+=.tmp
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=.webassets-cache/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=.vagrant/**
set wildignore+=.coverage/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app"

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')              " Support resizing in tmux
    set ttymouse=xterm2
endif

" move vertically by visual line (for wrapped lines)
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]

" folding
set nofoldenable            " dont fold by default
set foldnestmax=3           " 3 nested fold max
set foldmethod=indent       " fold based on indent level (or: marker, expr, syntax, diff)


" ==============================================================================
" Tab & Indent
" ==============================================================================

set expandtab               " tabs are spaces
set smarttab                " be smart when using tabs
set tabstop=4               " number of visual spaces per TAB
set softtabstop=4           " number of spaces in tab when editing
set shiftwidth=4            " number of spaces to use for each step of (auto)indent
set autoindent              " autoindent
set smartindent             " smartindent
set shiftround              " round indent to multiple of 'shiftwidth'.
set list listchars=tab:\ \ ,trail:·  " display tabs spaces visually
set nowrap                  " don't wrap line
set whichwrap+=h,l,<,>,[,],b,s,~

" filetype specifics (tabstop ts, shiftwidth sw, softtabstop sts)
autocmd Filetype python setlocal ts=4 sw=4 sts=4 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab



" ==============================================================================
" Searching
" ==============================================================================

set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " ignore case when searching
set smartcase               " be smart when searching
set magic                   " for regex turn magic on
" use white color for search highlight
highlight search cterm=NONE ctermfg=black ctermbg=228
" turn off search highlight
nnoremap <ESC><ESC> :nohlsearch<CR>:match<CR>
" Auto escape / in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
" search for word under the cursor
nnoremap <C-_> "fyiw :/<c-r>f<cr>N
" make incsearch color green
highlight IncSearch cterm=NONE ctermfg=black ctermbg=46



" ==============================================================================
" Plugins
" ==============================================================================

" Gundo
" ----
if isdirectory(bundledir.'/gundo.vim')
    nnoremap <leader>u :GundoToggle<CR>
    let g:gundo_preview_bottom=1            " prevew win the bottom for more room

    highlight clear DiffAdded
    highlight clear DiffRemoved
    highlight DiffAdded cterm=NONE ctermfg=white ctermbg=2
    highlight DiffRemoved cterm=NONE ctermfg=white ctermbg=1
endif


" NERDCommenter
" ----
if isdirectory(bundledir.'/nerdcommenter')
    let NERDSpaceDelims=1
endif


" VimFiler
" ----
if isdirectory(bundledir.'/vimfiler.vim')
    nnoremap <leader>e :VimFiler -find -simple<CR>
    call vimfiler#custom#profile('default', 'context', {
        \   'safe' : 0,
        \   'explorer' : 1
        \ })

    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_no_default_key_mappings = 1
    let g:vimfiler_expand_jump_to_first_child = 0

    " display aesthetics
    let g:vimfiler_tree_leaf_icon = '├'
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '┄'
    let g:vimfiler_readonly_file_icon = 'x'
    let g:vimfiler_marked_file_icon = '*'
    let g:vimfiler_tree_indentation = 3
    let g:vimfiler_time_format = '%m-%d-%Y %H:%M:%S'

    " don't show these files or directories
    let g:vimfiler_ignore_pattern = '^\(' . join(general_ignore_pattern, '\|') . '\)$'

    " Inside vimfiler buffer settings
    autocmd MyAutoCmd FileType vimfiler call s:my_vimfiler_settings()
    function! s:my_vimfiler_settings()
        setlocal sidescrolloff=0

        " mimic toggle behavior
        nmap <buffer> <leader>e <Plug>(vimfiler_hide)

        nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
        nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
        nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
        " nmap <buffer> O <Plug>(vimfiler_expand_tree_recursive)
        nmap <buffer> q <Plug>(vimfiler_hide)
        nmap <buffer> Q <Plug>(vimfiler_exit)

        nmap <buffer> x <Plug>(vimfiler_toggle_mark_current_line)
        nmap <buffer> X <Plug>(vimfiler_toggle_mark_current_line_up)
        nmap <buffer> U <Plug>(vimfiler_clear_mark_all_lines)
        nmap <buffer> * <Plug>(vimfiler_toggle_mark_all_lines)
        nmap <buffer> # <Plug>(vimfiler_mark_similar_lines)

        nmap <buffer> ~ <Plug>(vimfiler_switch_to_home_directory)
        nmap <buffer> \ <Plug>(vimfiler_switch_to_root_directory)
        " nmap <buffer> & <Plug>(vimfiler_switch_to_project_directory)
        nmap <buffer> - <Plug>(vimfiler_switch_to_parent_directory)
        nmap <buffer> . <Plug>(vimfiler_toggle_visible_ignore_files)
        nmap <buffer> yy <Plug>(vimfiler_yank_full_path)

        " nmap <buffer> gs <Plug>(vimfiler_toggle_safe_mode)
        nmap <buffer> + <Plug>(vimfiler_new_file)
        nmap <buffer> M <Plug>(vimfiler_move_file)
        nmap <buffer> C <Plug>(vimfiler_copy_file)
        nmap <buffer> D <Plug>(vimfiler_delete_file)
        nmap <buffer> R <Plug>(vimfiler_rename_file)
        nmap <buffer> K <Plug>(vimfiler_make_directory)
        nmap <buffer> <c-c> <Plug>(vimfiler_clipboard_copy_file)
        nmap <buffer> <c-v> <Plug>(vimfiler_clipboard_paste)

        nmap <buffer> gr <Plug>(vimfiler_grep)
        nmap <buffer> gf <Plug>(vimfiler_find)
        nmap <buffer> p <Plug>(vimfiler_preview_file)
        nmap <buffer> \| <Plug>(vimfiler_choose_action)

    endfunction
endif


" Unite
" ----
if isdirectory(bundledir.'/unite.vim')
    let g:unite_source_history_yank_enable = 1
    let g:unite_no_default_keymappings = 1

    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])

    " https://github.com/Shougo/unite.vim/issues/374
    let g:unite_source_rec_max_cache_files = 0
    call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)

    call unite#custom#profile('default', 'context', {
        \ 'no_split': 1,
        \ 'max_multi_lines': 1,
        \ 'toggle': 1,
        \ 'prompt': '>> ',
        \ })
        " \ 'vertical_preview': 1,

    call unite#custom#profile('file_rec,line', 'context', {
        \ 'start_insert': 1,
        \ })

    call unite#custom#profile('buffer,grep', 'context', {
        \ 'no_empty': 1,
        \ })

    call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
        \ 'ignore_pattern', join(search_ignore_pattern, '\|')
        \ )

    " Key mappings to invoke Unite.
    nnoremap <leader>t :<C-u>Unite -buffer-name=file_rec            file_rec/async:!<cr>
    nnoremap <leader>y :<C-u>Unite -buffer-name=yank                history/yank<cr>
    nnoremap <leader>f :<C-u>Unite -buffer-name=file                file<cr>
    nnoremap <leader>r :<C-u>Unite -buffer-name=mru                 file_mru<cr>
    nnoremap <leader>o :<C-u>Unite -buffer-name=buffer              buffer<cr>
    nnoremap <leader>b :<C-u>Unite -buffer-name=buffer              buffer<cr>
    nnoremap <leader>/ :<C-u>Unite -buffer-name=grep                grep:!<cr>
    nnoremap <leader>\ :<C-u>Unite -buffer-name=line -auto-preview  line<cr>

    " Use ag for search
    if executable('ag')
        let g:unite_source_rec_async_command =
                \ ['ag', '--follow', '--nocolor', '--nogroup',
                \  '--hidden', '--skip-vcs-ignores',
                \  '--path-to-agignore', '~/.agignore',
                \  '-g', '']

        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
                \ '--line-numbers --nocolor --nogroup --hidden --smart-case --skip-vcs-ignores'
        let g:unite_source_grep_recursive_opt = ''
        let g:unite_source_grep_search_word_highlight = 'Special'
    endif

    " Inside unite buffer settings
    autocmd MyAutoCmd FileType unite call s:my_unite_settings()
    function! s:my_unite_settings()
        setlocal number
        setlocal nowrap

        " Custome key mappings ------------------------------------------------
        nmap <buffer><nowait> <c-q> <Plug>(unite_all_exit)
        imap <buffer><nowait> <c-q> <c-o><Plug>(unite_all_exit)<esc>
        xmap <buffer><nowait> <c-q> <Plug>(unite_all_exit)

        nmap <buffer><nowait> i gg$l<Plug>(unite_insert_enter)
        nmap <buffer><nowait> - <Plug>(unite_exit)
        nmap <buffer><nowait> _ <Plug>(unite_all_exit)
        nmap <buffer><nowait> + <Plug>(unite_new_candidate)
        nmap <buffer><nowait> x <Plug>(unite_toggle_mark_current_candidate)
        nmap <buffer><nowait> X <Plug>(unite_toggle_mark_current_candidate_up)
        nmap <buffer><nowait> p <Plug>(unite_toggle_auto_preview)
        nmap <buffer><nowait> \| <Plug>(unite_choose_action)
        nmap <buffer><nowait> T <Plug>(unite_redraw)

        nnoremap <silent><buffer><expr> v unite#do_action('vsplit')
        nnoremap <silent><buffer><expr> s unite#do_action('split')

        " imap <buffer> <TAB>     <plug>(unite_insert_leave)
        imap <buffer> <Tab>     <Plug>(unite_complete)
        imap <buffer> <CR>      <Plug>(unite_insert_leave)<Plug>(unite_select_next_line)

        " For search and replace.
        let unite = unite#get_current_unite()
        if unite.profile_name ==# 'search'
            nnoremap <silent><buffer><expr> R     unite#do_action('replace')
        else
            nnoremap <silent><buffer><expr> R     unite#do_action('rename')
        endif

        " Default key mappings ------------------------------------------------
        nmap <buffer><nowait> <CR> <Plug>(unite_do_default_action)
        nmap <buffer><nowait> * <Plug>(unite_toggle_mark_all_candidates)
        nmap <buffer><nowait> . <Plug>(unite_narrowing_dot)
    endfunction

    " neomru.vim source settings
    let g:neomru#filename_format = ':~:.'

    " qfreplace.vim
    autocmd MyAutoCmd FileType qf nnoremap <buffer> R :<C-u>Qfreplace<CR>
endif


" Fugitive
" ----
if isdirectory(bundledir.'/vim-fugitive')
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    " Mnemonic _i_nteractive
    nnoremap <silent> <leader>gi :Git add -p %<CR>
endif


" Gitv
if isdirectory(bundledir.'/gitv')
" https://github.com/joedicastro/dotfiles/blob/master/vim/vimrc
" nnoremap <silent> <leader>gv :Gitv --all<CR>
" nnoremap <silent> <leader>gV :Gitv! --all<CR>

" let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
" let g:Gitv_WrapLines = 1
" autocmd FileType git set nofoldenable
endif


" Syntastic
" ----
if isdirectory(bundledir.'/syntastic')
    " Don't auto populate message list
    let g:syntastic_always_populate_loc_list = 0
    "  window will NOT be automatically opened when errors are detected,
    "  and closed when none are detected
    let g:syntastic_auto_loc_list = 0
    " check on open as well as save
    let g:syntastic_check_on_open = 1
    " don't bother when quiting
    let g:syntastic_check_on_wq = 0

    " Styling
    let g:syntastic_error_symbol='⚑'
    let g:syntastic_warning_symbol='⚐'
    let g:syntastic_style_error_symbol = 'š'
    let g:syntastic_style_warning_symbol = 'ś'
    let g:syntastic_stl_format = '[Syntax %E{ERR:%e}%B{, }%W{WARN:%w}]'

    " Linters
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_python_checkers = ['pylint']
    " let g:syntastic_coffee_coffeelint_args = '-f ~/.config/coffeelint.json'
    " let g:syntastic_c_config_file = '.clang_complete'
    " let g:syntastic_cpp_config_file = '.clang_complete'
    " let g:syntastic_java_javac_config_file_enabled = 1
    " let g:syntastic_cpp_compiler = 'clang++'
    " let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

    let g:syntastic_mode_map = { 'mode': 'active',
                \ 'active_filetypes': [],
                \ 'passive_filetypes': [] }
endif


" airline
" ----
if isdirectory(bundledir.'/vim-airline')
    let g:airline_theme='powerlineish'
    " powerlineish theme copypasta below, need them here to modify.
    " color reference: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
    " --------------------------------------------------------------------------
    " Normal mode                                    " fg             & bg
    let s:N1 = [ '#005f00' , '#afd700' , 22  , 148 ] " darkestgreen   & brightgreen
    let s:N2 = [ '#9e9e9e' , '#303030' , 247 , 236 ] " gray8          & gray2
    let s:N3 = [ '#ffffff' , '#4e4e4e' , 231 , 239 ] " white          & some lighter gray                           -> MODIFIED for ligher gray bg
    " Insert mode                                    " fg             & bg
    let s:I1 = [ '#005f5f' , '#ffffff' , 23  , 231 ] " darkestcyan    & white
    let s:I2 = [ '#5fafd7' , '#0087af' , 74  , 31  ] " darkcyan       & darkblue
    let s:I3 = [ '#87d7ff' , '#005f87' , 117 , 27  ] " mediumcyan     & really obvious blue                         -> MODIFIED for ligher blue bg
    " Visual mode                                    " fg             & bg
    let s:V1 = [ '#080808' , '#ffaf00' , 232 , 214 ] " gray3          & brightestorange
    " Replace mode                                   " fg             & bg
    let s:RE = [ '#ffffff' , '#d70000' , 231 , 160 ] " white          & brightred

    let g:airline#themes#powerlineish#palette = {}
    let g:airline#themes#powerlineish#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

    let g:airline#themes#powerlineish#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
    let g:airline#themes#powerlineish#palette.insert_replace = {
        \ 'airline_a': [ s:RE[0]   , s:I1[1]   , s:RE[1]   , s:I1[3]   , ''     ] }

    let g:airline#themes#powerlineish#palette.visual = {
        \ 'airline_a': [ s:V1[0]   , s:V1[1]   , s:V1[2]   , s:V1[3]   , ''     ],
        \ 'airline_z': [ s:V1[0]   , s:V1[1]   , s:V1[2]   , s:V1[3]   , ''     ]
        \ }                                                                                                         " -> ADDED airline_z

    let g:airline#themes#powerlineish#palette.replace = copy(airline#themes#powerlineish#palette.normal)
    let g:airline#themes#powerlineish#palette.replace.airline_a = [ s:RE[0] , s:RE[1] , s:RE[2] , s:RE[3] , '' ]
    let g:airline#themes#powerlineish#palette.replace.airline_z = [ s:RE[0] , s:RE[1] , s:RE[2] , s:RE[3] , '' ]    " -> ADDED airline_Z
    let s:IA = [ s:N2[1] , '#121212' , s:N2[3] , 233 , '' ]

    let g:airline#themes#powerlineish#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)

    " finally edit tabline color                                                                                    " -> MODIFIED
    let g:airline#themes#powerlineish#palette.tabline = {
        \ 'airline_tab':          s:IA,
        \ 'airline_tabsel':       s:N1,
        \ 'airline_tabtype':      s:N2,
        \ 'airline_tabfill':      s:IA,
        \ 'airline_tabmod':       ['#ffffff', '#ff00af', '231', '199'],
        \ 'airline_tabmod_unsel': ['#ff00af', '#121212', '199', '233'],
        \ 'airline_tabhid':       s:IA
        \ }
    " --------------------------------------------------------------------------

    " airline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.whitespace = 'ξ'

    " show and customize the tabline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
    let g:airline#extensions#tabline#fnamemod = ':t'
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    " customize the airline status line
    let g:airline_section_c = '%f%m'
    let g:airline_section_z = '␤ %l/%L,%2v'
endif


" TMUX
" ----
" fix cursor
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" Bbye
if isdirectory(bundledir.'/vim-bbye')
    nnoremap <leader>q :Bdelete<CR>
endif


" EasyMotion
" ----
if isdirectory(bundledir.'/vim-easymotion')
  nmap <leader>s <Plug>(easymotion-s2)

  " easymotion highlight colors, make them easier to see
  highlight link EasyMotionTarget2First EasyMotionTarget
  highlight link EasyMotionTarget2Second EasyMotionTarget
endif


" TagBar
" ----
if isdirectory(bundledir.'/tagbar')
    let g:tagbar_left = 1
    let g:tagbar_width = 30
    let g:tagbar_foldlevel = 1
    let g:tagbar_autofocus = 1
    let g:tagbar_compact = 1
    let g:tagbar_sort = 0
    nnoremap <silent><F3> :TagbarToggle<CR>
endif


" Tabularize
" ----
if isdirectory(bundledir.'/tabular')
    nnoremap <leader>a= :Tabularize /=<CR>
    vnoremap <leader>a= :Tabularize /=<CR>
    nnoremap <leader>a: :Tabularize /:<CR>
    vnoremap <leader>a: :Tabularize /:<CR>
    nnoremap <leader>at :Tabularize /\|<CR>
    vnoremap <leader>at :Tabularize /\|<CR>
    nnoremap <Leader>a, :Tabularize /,<CR>
    vnoremap <Leader>a, :Tabularize /,<CR>
endif


" Indent Guides
" ----
if isdirectory(bundledir.'/vim-indent-guides')
    let g:indent_guides_default_mapping = 0
    let indent_guides_auto_colors=0
    hi IndentGuidesOdd  ctermbg=black
    hi IndentGuidesEven ctermbg=black
    let g:indent_guides_start_level=2
    let g:indent_guides_guide_size=1
    nmap <F6> <Plug>IndentGuidesToggle
endif


" Unimpaired.vim
" ----
if isdirectory(bundledir.'/vim-unimpaired')
    " copypasta of move functions below, to bind these babies to the way I like.
    " http://stackoverflow.com/a/5382863/3479934
    " --------------------------------------------------------------------------
    function! s:Move(cmd, count, map) abort
        normal! m`
        silent! exe 'move'.a:cmd.a:count
        norm! ``
        silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
    endfunction

    function! s:MoveSelectionUp(count) abort
        normal! m`
        silent! exe "'<,'>move'<--".a:count
        norm! ``
        silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
    endfunction

    function! s:MoveSelectionDown(count) abort
        normal! m`
        exe "'<,'>move'>+".a:count
        norm! ``
        silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
    endfunction
    " --------------------------------------------------------------------------
    function! s:BlankUp(count) abort
        put!=repeat(nr2char(10), a:count)
        ']+1
        silent! call repeat#set("\<Plug>unimpairedBlankUp", a:count)
    endfunction

    function! s:BlankDown(count) abort
        put =repeat(nr2char(10), a:count)
        '[-1
        silent! call repeat#set("\<Plug>unimpairedBlankDown", a:count)
    endfunction
    " --------------------------------------------------------------------------
    " bind keys for 'up'
    " nnoremap <silent> ˚ :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
    " vnoremap <silent> ˚ :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>gv
    vnoremap <silent><c-k> :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>gv
    " down keys for 'down'
    " nnoremap <silent> ∆ :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
    " vnoremap <silent> ∆ :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>gv
    vnoremap <silent><c-j> :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>gv
    " insert blank lines
    nnoremap <silent> <CR>          :<C-U>call <SID>BlankUp(v:count1)<CR>
    nnoremap <silent> <leader><CR>  :<C-U>call <SID>BlankDown(v:count1)<CR>
endif


" " Python Mode
" " ----
" let g:pymode_trim_whitespaces = 0               " we already do this manually
" let g:pymode_virtualenv=0                       " don't worry about venv
" " Documentation
" let g:pymode_doc = 1
" let g:pymode_doc_key = ''
" " Linting
" let g:pymode_lint = 1
" let g:pymode_lint_checkers = ['pyflakes', 'pep8']
" let g:pymode_lint_ignore = 'C0111,D100,D101,D102,D103,E501,W391,E702,E131'
" let g:pymode_lint_sort = ['E', 'C', 'W', 'R', 'I', 'F', 'D']
" let g:pymode_lint_unmodified = 1
" " Auto check on save
" let g:pymode_lint_write = 1
" " Enable breakpoints plugin
" let g:pymode_breakpoint = 0
" " let g:pymode_breakpoint_bind = '<leader>b'
" " syntax highlighting
" let g:pymode_syntax = 1
" let g:pymode_syntax_all = 1
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all
" " Don't autofold code
" let g:pymode_folding = 0
" " Python rope
" let g:pymode_rope = 1
" let g:pymode_rope_completion = 0
" let g:pymode_rope_complete_on_dot = 0


" delimitmate
" ----
if isdirectory(bundledir.'/delimitMate')
    let delimitMate_expand_space = 1
    let delimitMate_expand_cr = 1

    autocmd MyAutoCmd FileType vim let b:delimitMate_quotes = "'"
endif


" vim-smooth-scroll
if isdirectory(bundledir.'/vim-smooth-scroll')
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
endif


" YouCompleteMe
if isdirectory(bundledir.'/YouCompleteMe')
  " Placeholder
endif


" sirver/ultisnips + YCM + Supertab
" Make them play nice together: http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
if isdirectory(bundledir.'/ultisnips') && isdirectory(bundledir.'/YouCompleteMe') && isdirectory(bundledir.'/supertab')
  " make YCM compatible with UltiSnips (using supertab)
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  let g:SuperTabDefaultCompletionType = '<C-n>'

  " better key bindings for UltiSnipsExpandTrigger
  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
endif


" elzr/vim-json
let g:vim_json_syntax_conceal = 0


" ==============================================================================
" Other Stuff
" ==============================================================================

" don't accidently get into Ex mode
nnoremap Q <nop>

" toggle paste mode
set pastetoggle=<F2>
" nicely paste from clipboard in visual mode
inoremap <C-v> <F2><C-r>+<F2>
" niclely yank visual selection into clipboard
vnoremap <C-c> "+y
" insert mode with paste using F2 key (NOT USED)
nnoremap <silent> <leader><F2> :set paste<CR>i
" Leave paste mode on exit
autocmd InsertLeave * set nopaste

" toggle relative numbering
nnoremap <F5> :set relativenumber!<cr>

" spell check toggle
nnoremap <F7> :setlocal spell! spelllang=en_us<CR>
" bad spelling highlight
hi SpellBad ctermfg=189 cterm=undercurl
" if want to sync across different machines
" set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add

" Easily move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Sublime style indentation
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" switch between current and last buffer
nnoremap <silent><leader><tab> <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>

" scroll the viewport faster
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" provide hjkl movements in insert mode via the <C> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" disable vim looking up man page
nnoremap <S-k> <nop>
xnoremap <S-k> <nop>

" forward and backward for searched character
nnoremap \ ;
nnoremap \| ,

"Like D for yanking
noremap Y y$

" wipteout buffer and window together
noremap <c-q> :bw<cr>

" Pull word under cursor into LHS of a substitute
" nnoremap <leader>z :%s#\<<c-r>=expand("<cword>")<cr>\>##gc<left><left><left>
" nnoremap <leader>Z :bufdo %s#\<<c-r>=expand("<cword>")<cr>\>##gce<space><bar><space>update<left><left><left><left><left><left><left><left><left><left><left><left><left>

" Check syntax color group
function! <SID>CheckSyntaxItem()
    echo synIDattr(synID(line("."), col("."), 1), "name")
endfunction
nnoremap <F10> :call <SID>CheckSyntaxItem()<CR>

" tidy up trailing white spaces and empty endlines
function! <SID>StripTrailingWhitespacesAndEmptyEndLines()
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " strip trailing white spaces
    :silent! %s/\s\+$//e
    " Strip empty end lines.
    :silent! %s#\($\n\s*\)\+\%$##
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespacesAndEmptyEndLines()
nnoremap <F8> :call <SID>StripTrailingWhitespacesAndEmptyEndLines()<CR>

" Make directory automatically
autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force)
    if !isdirectory(a:dir) && &l:buftype == '' &&
            \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
            \              a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction


" XML formatter (Reference: http://vim.wikia.com/wiki/Pretty-formatting_XML)
function! DoFormatXML() range
  " Save the file type
  let l:origft = &ft

  " Clean the file type
  set ft=

  " Add fake initial tag (so we can process multiple top-level elements)
  exe ":let l:beforeFirstLine=" . a:firstline . "-1"
  if l:beforeFirstLine < 0
    let l:beforeFirstLine=0
  endif
  exe a:lastline . "put ='</PrettyXML>'"
  exe l:beforeFirstLine . "put ='<PrettyXML>'"
  exe ":let l:newLastLine=" . a:lastline . "+2"
  if l:newLastLine > line('$')
    let l:newLastLine=line('$')
  endif

  " Remove XML header
  exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

  " Recalculate last line of the edited code
  let l:newLastLine=search('</PrettyXML>')

  " Execute external formatter
  exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

  " Recalculate first and last lines of the edited code
  let l:newFirstLine=search('<PrettyXML>')
  let l:newLastLine=search('</PrettyXML>')

  " Get inner range
  let l:innerFirstLine=l:newFirstLine+1
  let l:innerLastLine=l:newLastLine-1

  " Remove extra unnecessary indentation
  exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

  " Remove fake tag
  exe l:newLastLine . "d"
  exe l:newFirstLine . "d"

  " Put the cursor at the first line of the edited code
  exe ":" . l:newFirstLine

  " Restore the file type
  exe "set ft=" . l:origft
endfunction

command! -range=% FormatXML <line1>,<line2>call DoFormatXML()
" nmap <silent> <leader>x :%FormatXML<CR>
