" ==============================================================================
" Plugin Manager
" ==============================================================================

let plugged = expand('~/.vim/plugged')

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(plugged)

" Appearance
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'RRethy/vim-illuminate'

" Maneuvering
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-bufkill'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-sneak'

" Editing
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'

" Searching & Replacing
Plug 'google/vim-searchindex'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'stefandtw/quickfix-reflector.vim'

" Version control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Code intelligence
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" Testing
Plug 'vim-test/vim-test'

" Initialize plugin system
call plug#end()


" ==============================================================================
" General Config
" ==============================================================================

if &compatible
  set nocompatible              " Be iMproved
endif

" space as leader (https://stackoverflow.com/a/9578616)
nnoremap <space> <Nop>
map <space> <Leader>

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

" auto read when a file is changed from outside
set autoread

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

" command waiting time, history, buffer info
set ttimeout
set ttimeoutlen=30
set history=1000                " store lots of :cmdline history
set viminfo^=%                  " remember info about open buffers on close

" Persistent undo settings
if has("persistent_undo")
  set undofile
  set undodir=~/.vim/undofiles/
  set undolevels=1000
  set undoreload=10000
endif

" completion sources
set infercase                   " Ignore case on insert completion.
set complete-=i                 " http://stackoverflow.com/a/2460593/3479934
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

" helps vim-gitgutter, coc-nvim updates faster
" https://www.reddit.com/r/vim/comments/3ql651
set updatetime=150


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
set numberwidth=3               " keep min column spacing tight (1 + 2)
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
set backspace=indent,eol,start  " sane backspace
set mouse=a                     " Enable basic mouse behavior such as resizing buffers.

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
set tabstop=2               " number of visual spaces per TAB
set softtabstop=2           " number of spaces in tab when editing
set shiftwidth=2            " number of spaces to use for each step of (auto)indent
set autoindent              " autoindent
set smartindent             " smartindent
set shiftround              " round indent to multiple of 'shiftwidth'.
set list listchars=tab:\ \ ,trail:·  " display tabs spaces visually
set nowrap                  " don't wrap line


" ==============================================================================
" Searching
" ==============================================================================

set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ignorecase              " ignore case when searching
set smartcase               " be smart when searching
set magic                   " for regex turn magic on

" By default turn off search highlight with esc
let g:esc_commands = [':nohlsearch', ':match']
nnoremap <silent> <ESC> :execute join(g:esc_commands, '\|')<CR>


" ==============================================================================
" Custom Behavior
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

" cycle through buffers (https://stackoverflow.com/a/5563142)
" if available, replace with vim-bufkill implementations
nnoremap <silent> <tab> :bnext<CR>
nnoremap <silent> <s-tab> :bprevious<CR>
nnoremap <silent> <leader><tab> <C-^>

" Close all buffers but this one (https://stackoverflow.com/a/42071865)
command! BufOnly silent! execute "%bd|e#|bd#"

" go to tab by number (https://superuser.com/a/675119)
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :execute "tabn ".g:last_tab<cr>
autocmd TabLeave * let g:last_tab = tabpagenr()

" enable . command in visual mode
vnoremap . :normal .<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" disable vim looking up man page
nnoremap <S-k> <nop>
xnoremap <S-k> <nop>

"Like D for yanking
noremap Y y$

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
let s:noAutoStripFileTypes = []  " http://stackoverflow.com/a/10410590/3479934
autocmd BufWritePre * if index(s:noAutoStripFileTypes, &ft) < 0 |
    \ :call <SID>StripTrailingWhitespacesAndEmptyEndLines()

" Highlight word under cursor without moving..
" http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches#Highlight_matches_without_moving
nnoremap <Leader><Space> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>


" ==============================================================================
" Function Keys
" ==============================================================================

" Manual trigger to strip trailing spaces.
nnoremap <F5> :call <SID>StripTrailingWhitespacesAndEmptyEndLines()<CR>

" toggle relative numbering
nnoremap <F6> :set relativenumber!<cr>

" spell check toggle
nnoremap <F7> :setlocal spell! spelllang=en_us<CR>
hi SpellBad ctermfg=131 cterm=undercurl


" ==============================================================================
" Plugins
" ==============================================================================

" vim-airline
" ---
if isdirectory(plugged.'/vim-airline')
  " Turn off a dirvish integration, keeps erroring out (as of Aug 2020, maybe
  " check again at some point).
  let g:airline#extensions#dirvish#enabled = 0
endif

" vim-illuminate
" ---
if isdirectory(plugged.'/vim-illuminate')
  " Teal color works well with molokai theme.
  " #285e61 (bg-teal-800) -> #275A5D -> #26565A (mid point) -> #245256 -> #234e52 (bg-teal-900)
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord guibg=#26565A  " tailwindcss bg-teal-800
  augroup END

  " Let esc also clear illumination.
  let g:esc_commands += [':call illuminate#on_leaving_autocmds()']
endif

" vim-dirvish
" ---
if isdirectory(plugged.'/vim-dirvish')
  " Highlight selected files in argslist look more distinct.
  highlight link DirvishArg CursorLineNr

  " Execute the following commands to sort and filter after listing files.
  " https://github.com/justinmk/vim-dirvish/blob/master/doc/dirvish.txt
  " https://github.com/justinmk/vim-dirvish/issues/89#issuecomment-352419682
  "
  " :sort:      First sort dot-files, then sort folders at the top
  " :silent:    Remove 'Hit ENTER to continue' prompt
  " :global:    Filter out files matched by given patterns
  let g:dirvish_mode = ':sort | :sort ,^.*[\/], | :silent :keeppatterns :global/\.DS_Store$/d _'

  " Undo the weird regex thing vim-dirvish does (e.g. /\ze[^\/]*[\/]\=$<Home>)
  " https://github.com/justinmk/vim-dirvish/blob/master/ftplugin/dirvish.vim#L50
  autocmd FileType dirvish nnoremap <buffer> / /
  autocmd FileType dirvish nnoremap <buffer> ? ?

  " Don't allow shortcuts to cycle through buffers while in dirvish
  autocmd FileType dirvish noremap <buffer> <tab> <nop>
  autocmd FileType dirvish noremap <buffer> <s-tab> <nop>

  " Open file in a new tab (copied from documentation)
  autocmd FileType dirvish nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  autocmd FileType dirvish xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>

  " Load current arglist into a dirvish buffer
  " https://github.com/justinmk/vim-dirvish/issues/151#issuecomment-549568252
  " https://askubuntu.com/a/1098612
  autocmd FileType dirvish nnoremap <silent><buffer> eax :%!ls -d ##<CR>
endif

" nerdtree
" ---
if isdirectory(plugged.'/nerdtree')
  " https://stackoverflow.com/a/31631030/3479934
  function! ToggleNERDTreeFind()
    if g:NERDTree.IsOpen()
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction
  nnoremap <leader>r :call ToggleNERDTreeFind()<CR>

  let NERDTreeHijackNetrw = 0               " Don't be the default
  let NERDTreeShowHidden = 1                " Show hidden files
  let NERDTreeAutoDeleteBuffer = 1          " Auto delete the buffer of the file you just deleted.
  let NERDTreeWinSize = 45                  " The default of 31 is just a little too narrow.
  let NERDTreeMinimalUI = 1                 " Disable display of '?' text and 'Bookmarks' label.
  let NERDTreeIgnore = ['\.DS_Store$']      " Don't bother showing these files
  let NERDTreeMapQuit = 'gq'                " Make consistent with vim-dirvish

  " Don't allow - to trigger vim-dirvish
  autocmd FileType nerdtree noremap <buffer> - <nop>
endif

" vim-sneak
" ---
if isdirectory(plugged.'/vim-sneak')
  " Let esc also exit neak mode.
  let g:esc_commands += [':call sneak#cancel()']
endif

" vim-bufkill
" ---
if isdirectory(plugged.'/vim-bufkill')
  " Replaces native commands with better implementations by vim-bufkill.
  nnoremap <silent> <tab> :BF<CR>
  nnoremap <silent> <s-tab> :BB<CR>
  let g:BufKillOverrideCtrlCaret = 1
endif

" vim-visual-multi
" ---
if isdirectory(plugged.'/vim-visual-multi')
  " Make selection highlight more obvious
  let g:VM_theme = 'olive'

  " Use normal search highlight for matches
  let g:VM_highlight_matches = ''
endif

" NERDcommenter
" ---
if isdirectory(plugged.'/nerdcommenter')
  " Add spaces after comment delimiters by default
  let NERDSpaceDelims = 1

  " Allow commenting and inverting empty lines (useful when commenting a region)
  let NERDCommentEmptyLines = 1
endif

" fzf
" ---
if isdirectory(plugged.'/fzf.vim')
  let g:fzf_preview_window = ['right:50%', 'F2']

  " Buffers
  "
  nnoremap <silent> <leader>u :Buffers!<CR>

  " Files
  "
  " Run GFiles if inside git repo, otherwise Files
  " https://github.com/junegunn/fzf.vim/issues/233
  command! SmartGFiles execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles!' : 'Files!'
  nnoremap <silent> <leader>p :SmartGFiles<CR>

  " Search
  "
  " From docs with modifications
  " https://github.com/junegunn/fzf.vim#example-rg-command-with-preview-window
  " https://github.com/junegunn/fzf.vim/issues/419
  "
  " with rg options: --follow --hidden --vimgrep
  " with binding: F2:toggle-preview
  " without -- and .shellescape at the end, to allow passing in more flags as needed
  function! RipgrepFzf(query, fullscreen)
    let command = 'rg --column --line-number --no-heading --color=always --smart-case --follow --hidden --vimgrep '.a:query
    call fzf#vim#grep(command, 1, fzf#vim#with_preview(), a:fullscreen)
  endfunction

  " Prompt for search term first and quit if none given
  function! RipgrepPrompt(fullscreen)
    let query = input('Rg/')
    if len(query)
      call RipgrepFzf(query, a:fullscreen)
    endif
  endfunction
  command! -nargs=* -bang RipgrepPrompt call RipgrepPrompt(<bang>0)

  " Finally key binding to search with ripgrep
  nnoremap <silent> <leader>/ :execute 'RipgrepPrompt!'<CR>
endif

" vim-test
" ---
if isdirectory(plugged.'/vim-test')
  nmap <silent> <leader>tn :TestNearest<CR>
  nmap <silent> <leader>tf :TestFile<CR>
  nmap <silent> <leader>ts :TestSuite<CR>
  nmap <silent> <leader>tl :TestLast<CR>
endif

" vim-gitgutter
" ---
if isdirectory(plugged.'/vim-gitgutter')
  " don't set up any mappings at all
  let g:gitgutter_map_keys = 0
endif

" coc.nvim
" ---
if isdirectory(plugged.'/coc.nvim')
  " https://vi.stackexchange.com/a/9254
  runtime ./coc.nvim.vim
endif


" ==============================================================================
" ==============================================================================

" vim-colorschemes
" ---
if isdirectory(plugged.'/vim-colorschemes')
  colorscheme molokai
endif

" Improvments list
" + Configure rg to exclude .git directory
