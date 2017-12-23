" ==============================================================================
" Plugin Manager
" ==============================================================================

" Automatic installation
" https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
let pluggeddir = expand('~/.vim/plugged')
call plug#begin(pluggeddir)


" NOTE: Make sure you use single quotes

" Vim appearance
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sleuth'
Plug 'Yggdroot/indentLine'

" Editing, Maneuvering & Seaching
" NOTE: 'henrik/vim-indexed-search' doesn't play well with easymotion
Plug 'haya14busa/incsearch.vim' | Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dkprice/vim-easygrep'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

" Code intelligence
" NOTE: 'ervandew/supertab' doesn't play well with deoplete, don't use.
Plug 'honza/vim-snippets'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'

" Version control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
" Plug 'mtscout6/syntastic-local-eslint.vim'

" Reason/OCaml
Plug 'reasonml/vim-reason'

" Markdown
Plug 'plasticboy/vim-markdown'

" HTML and etc.
Plug 'alvan/vim-closetag'

" Misc.
Plug 'hashivim/vim-terraform'   " Terraform
Plug 'ekalinin/Dockerfile.vim'  " Docker
Plug 'chr4/nginx.vim'           " Nginx
Plug 'wincent/terminus'         " Enhanced terminal ux

" Initialize plugin system
call plug#end()


" NOTE: http://hew.tools/blog/posts/asynchronous-neovim-in-2016/
" https://github.com/vimwiki/vimwiki


" ==============================================================================
" General Config
" ==============================================================================

if &compatible
  set nocompatible               " Be iMproved
endif

" , and space as leader
let mapleader=','
:map <space> <leader>

" swap : vs ;
nnoremap : ;
nnoremap ; :

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

" Persistent undo settings
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



" ==============================================================================
" User Interface
" ==============================================================================

" (Any change in colors must come after this section)
syntax on                       " enable syntax processing
set termguicolors               " This line enables the true color support.
set modeline                    " read modline for syntax
set synmaxcol=320               " don't bother syntax highlight beyond this
set background=dark             " colorscheme

set number                      " show line numbers..
set relativenumber              " ..mixed with relative numbers
set numberwidth=5               " give a bit more space for line numbers
set showcmd                     " show command in bottom bar

set lazyredraw                  " redraw only when we need to
set showmatch                   " highlight matching [{()}]
set matchpairs+=<:>             " Highlight <>
set matchtime=2                 " how many tenths of a second to blink when matching brackets
set scrolloff=7                 " set 7 lines to the cursor - when moving vertically using j/k
set nostartofline               " don't move me around to the front automatically
set sidescrolloff=20            " set 20 cols to the cursor when moving horizontally
set colorcolumn=81              " line length marker
set laststatus=2                " always show statusline
set ruler                       " show where you are
set hidden                      " current buffer can be put into background
set title                       " set terminal title
set virtualedit=onemore         " allow one more character
set viewoptions="folds,options,cursor,unix,slash"     "unix/windows compatibility
set tildeop                     " Tilde acts as an operator
set splitbelow                  " Open new split panes to right and bottom..
set splitright                  " ...which feels more natural

" sane backspace
set backspace=2
set backspace=indent,eol,start

set mouse=a                     " Enable basic mouse behavior such as resizing buffers.
" if exists('$TMUX')            " Support resizing in tmux
"     set ttymouse=xterm2
" endif

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
" set whichwrap+=h,l,<,>,[,],b,s,~



" ==============================================================================
" Searching
" ==============================================================================

set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " ignore case when searching
set smartcase               " be smart when searching
set magic                   " for regex turn magic on

" turn off search highlight
nnoremap <TAB> :nohlsearch<CR>:match<CR>

" Prefer ag for grepprg
set grepformat=%f:%l:%c:%m
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
endif



" ==============================================================================
" Other Stuff
" ==============================================================================

" Easily move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" provide hjkl movements in insert mode via the <C> modifier key
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" don't accidently get into Ex mode
nnoremap Q <nop>

" scroll the viewport faster
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

" Sublime style indentation
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" switch between current and last buffer
nnoremap <silent><leader><tab> <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

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

" Automatically jump to end of text you pasted:
" (so that you can paste multiple lines multiple times with simple ppppp)
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Strip trailing whitespaces at save
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
" Auto trigger to strip by default, unless exempted.
" e.g. let noAutoStripFileTypes = ['markdown']
let noAutoStripFileTypes = []  " http://stackoverflow.com/a/10410590/3479934
autocmd BufWritePre * if index(noAutoStripFileTypes, &ft) < 0 |
    \ :call <SID>StripTrailingWhitespacesAndEmptyEndLines()

" Automatically jump to end of text you pasted:
" (so that you can paste multiple lines multiple times with simple ppppp)
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]


" Highlight word under cursor without moving..
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches#Highlight_matches_without_moving
nnoremap <Leader><Space> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


" ==============================================================================
" Function Keys
" ==============================================================================

" toggle relative numbering
nnoremap <F5> :set relativenumber!<cr>

" Manual trigger to strip trailing spaces.
nnoremap <F6> :call <SID>StripTrailingWhitespacesAndEmptyEndLines()<CR>

" spell check toggle
nnoremap <F7> :setlocal spell! spelllang=en_us<CR>
" bad spelling highlight
hi SpellBad ctermfg=131 cterm=undercurl

" toggle indent lines
nnoremap <F8> :IndentLinesToggle<CR>


" ==============================================================================
" Plugins
" ==============================================================================

" vim-colorschemes
" ---
if isdirectory(pluggeddir.'/vim-colorschemes')
  colorscheme molokai
endif

" fzf (https://github.com/junegunn/fzf.vim)
" https://www.reddit.com/r/neovim/comments/3oeko4/post_your_fzfvim_configurations/
" ---
if isdirectory(pluggeddir.'/fzf.vim')
  " Run GFiles if inside git repo, otherwise Files
  " References :
  " https://github.com/junegunn/fzf.vim/issues/47
  " https://github.com/junegunn/fzf.vim/issues/233
  command! SmartGFiles execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles' : 'Files'
  nnoremap <silent> <leader>p :SmartGFiles<CR>

  nnoremap <silent> <leader>o :Buffers<CR>
  nnoremap <silent> <leader>/ :execute 'Ag! ' . input('Ag/')<CR>

  " Augmenting Ag command using fzf#vim#with_preview function
  "   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
  "     * For syntax-highlighting, Ruby and any of the following tools are required:
  "       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
  "       - CodeRay: http://coderay.rubychan.de/
  "       - Rouge: https://github.com/jneen/rouge
  "
  "   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
  "   :Ag! - Start fzf in fullscreen and display the preview window above
  command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)
endif

" vim-airline
" ---
if isdirectory(pluggeddir.'/vim-airline')
  if isdirectory(pluggeddir.'/ale')
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled = 1
  endif
endif

" ale
" ---
if isdirectory(pluggeddir.'/ale')
  let g:ale_lint_delay = 200

  nnoremap <silent> <C-p> :ALEPreviousWrap<CR>
  " nnoremap <silent> <C-n> :ALENextWrap<CR>

  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'jsx': ['eslint'],
  \}
endif

" vim-jsx
" ---
if isdirectory(pluggeddir.'/vim-jsx')
  let g:jsx_ext_required = 0
endif

" vim-easymotion
" ---
if isdirectory(pluggeddir.'/vim-easymotion')
  let g:EasyMotion_smartcase = 1

  " <Leader>f{char} to move to {char}
  map  <Leader>f <Plug>(easymotion-bd-f)
  nmap <Leader>f <Plug>(easymotion-overwin-f)

  " map  / <Plug>(easymotion-sn)
  " omap / <Plug>(easymotion-tn)

  " map  <Leader><Space> <Plug>(easymotion-bd-w)
  " nmap <Leader><Space> <Plug>(easymotion-overwin-w)

  " easymotion highlight colors, make them easier to see
  highlight link EasyMotionTarget2First EasyMotionTarget
  highlight link EasyMotionTarget2Second EasyMotionTarget
endif

" nerdtree
" ---
if isdirectory(pluggeddir.'/nerdtree')
  " https://stackoverflow.com/a/31631030/3479934
  function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction
  nnoremap <leader>r :call ToggleNERDTreeFind()<CR>

  " https://www.youtube.com/watch?v=OgQW07saWb0
  let NERDTreeShowHidden=1                  " Show hidden files
  let NERDTreeQuitOnOpen = 1                " Closing automatically on opening
  let NERDTreeAutoDeleteBuffer = 1          " Auto delete the buffer of the file you just deleted.
  let g:NERDTreeWinSize=40                  " The default of 31 is just a little too narrow.
  let g:NERDTreeMinimalUI=1                 " Disable display of '?' text and 'Bookmarks' label.
  let NERDTreeCreatePrefix='silent keepalt keepjumps'   " Keep the alt buffer around..?

  let NERDTreeMapQuit="<esc>"

  " Like vim-vinegar.
  nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : expand('%:p:h')<CR><CR>

  function! DoNERDTreeInit()
    " Move up a directory using "-" like vim-vinegar (usually "u" does this).
    nmap <buffer> <expr> - g:NERDTreeMapUpdirKeepOpen
  endfunction

  if has('autocmd')
    augroup NERDTreeAugroup
      autocmd!
      autocmd User NERDTreeInit call DoNERDTreeInit()
    augroup END
  endif

  " Don't bother showing these files
  let NERDTreeIgnore = ['\.pyc$', '\.DS_Store$']

endif

" deoplete.nvim
" ---
if isdirectory(pluggeddir.'/deoplete.nvim')
  " https://www.gregjs.com/vim/2016/neovim-deoplete-jspc-ultisnips-and-tern-a-config-for-kickass-autocompletion/
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#auto_complete_delay = 200
endif

" neosnippet
" ---
if isdirectory(pluggeddir.'/neosnippet')
  " Enable snipMate compatibility feature.
  let g:neosnippet#enable_snipmate_compatibility = 1

  " SuperTab like snippets behavior.
  " NOTE: It must be "imap" and "smap".  It uses <Plug> mappings.
  " imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  imap <expr><CR>
      \ pumvisible() && neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
  inoremap <expr><C-f>
      \ pumvisible() ? "\<Down>\<CR>" : "\<C-f>"
  imap <expr><TAB>
      \ pumvisible() ? "\<Down>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  imap <expr><S-TAB>
      \ pumvisible() ? "\<Up>" : "\<S-TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " Close the documentation window when completion is done
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif

  if isdirectory(pluggeddir.'/vim-snippets')
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory = pluggeddir.'/vim-snippets/snippets'
  endif
endif

" vim-easygrep
" ---
if isdirectory(pluggeddir.'/vim-easygrep')
  cnoreabbrev re Replace

  let g:EasyGrepCommand = 1                     " Use grepprg as configured
  let g:EasyGrepJumpToMatch = 0                 " Don't automatically jump
  let g:EasyGrepHidden = 1                      " Search hidden files too
  let g:EasyGrepOptionPrefix=''                 " No keybindings
  let g:EasyGrepFilesToExclude=".svn,.git"
endif

" ack.vim
" ---
if isdirectory(pluggeddir.'/ack.vim')
  cnoreabbrev ag Ack!

  if executable('ag')
    let g:ackprg = 'ag --vimgrep --nogroup --column --smart-case --nocolor --follow'
  endif
endif

" nerdcommenter
" ---
if isdirectory(pluggeddir.'/nerdcommenter')
  let NERDSpaceDelims=1

  " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDCommentEmptyLines = 1
endif

" vim-json
" ---
if isdirectory(pluggeddir.'/vim-json')
  let g:vim_json_syntax_conceal = 0
endif

" auto-pairs
" ---
if isdirectory(pluggeddir.'/auto-pairs')
  let g:AutoPairsMapCh = 0
endif

" vim-closetag
" ---
if isdirectory(pluggeddir.'/vim-closetag')
  let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'
  let g:closetag_emptyTags_caseSensitive = 1
endif

" incsearch.vim
" ---
if isdirectory(pluggeddir.'/incsearch.vim')
  let g:incsearch#auto_nohlsearch = 1
  " map / <Plug>(incsearch-stay)

  " Example:
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endif


" indentLine
" ---
if isdirectory(pluggeddir.'/indentLine')
  let g:indentLine_enabled = 0
endif
