" for Deoplete
" let g:python3_host_prog = 'C:\Users\Hagun\AppData\Local\Programs\Python\Python36\python.exe'

" Vim Plug {{{
call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'mhartington/oceanic-next'
Plug 'itchyny/lightline.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'zchee/deoplete-jedi'

call plug#end()

" }}}

syntax enable
colorscheme OceanicNext

if (has("termguicolors"))
 set termguicolors
endif

set mouse=a
let g:NERDTreeMouseMode=3 

" Spaces & Tabs {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
set list                " for trailing spaces
set listchars=trail:·,extends:>,precedes:<
" }}}

" UI Layout {{{
set number              " show line numbers
" Using lightline so don't need those
set noshowmode          " show mode in bottom bar
" set showcmd           " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu
set lazyredraw
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
" }}}

" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}

"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}

" Key Mapping {{{
inoremap jj <esc>
nnoremap <C-S-e> :NERDTreeToggle<CR>
" }}}
"
let g:deoplete#enable_at_startup = 1
