" Plugins List
call plug#begin()
    " UI related
    Plug 'joshdick/onedark.vim'
    Plug 'itchyny/lightline.vim'
    " Better Visual Guide
    Plug 'Yggdroot/indentLine'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " NERDTree
    Plug 'preservim/nerdtree'

    " Git plugin
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Session mamanger
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'

    " Auto insert, delete pairs
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'

    " Language support
    Plug 'sheerun/vim-polyglot'
    Plug 'cespare/vim-toml'
    Plug 'rust-lang/rust.vim'
    Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'typescript.tsx', 'typescriptreact']}
    Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

    " coc.nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Snippets
    Plug 'dsznajder/vscode-es7-javascript-react-snippets', { 'do': 'npm i --package-lock=false && npm run compile' }
call plug#end()

if has('win32')
  nmap <C-z> <Nop>
endif

" machine depend?
let mapleader=" "
set clipboard^=unnamed,unnamedplus
inoremap <C-U> <C-G>u<C-U>
command! BufOnly silent! execute "%bd|e#|bd#"

" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Set filetype for typescript
au FileType css setlocal sw=2 ts=2
au FileType html setlocal sw=2 ts=2
au FileType javascript setlocal sw=2 ts=2
au FileType javascriptreact setlocal sw=2 ts=2
au FileType typescript setlocal sw=2 ts=2
au FileType typescriptreact setlocal sw=2 ts=2

" Configurations Part
" UI configuration
filetype plugin indent on
syntax on
syntax enable

" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif

" colorscheme
set background=dark
colorscheme onedark

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

set number
set relativenumber
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw
set scrolloff=2

" Turn off backup
set nobackup
set nowritebackup
set noswapfile

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" Use <C-L> to clear the highlighting of :set hlsearch.
nnoremap <silent> <leader>l :noh<CR>

" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set nowrap

" Set show whitespace characters
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
" ASCII listchars
" set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" folding
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
set foldlevelstart=10   " start with fold level of 1
" nnoremap <space> za

" vim-sneak
let g:sneak#label = 1

" FZF
" TODO Temporarily fix for bash is not in PATH for windows
let g:fzf_preview_window = ''
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden . 2> nul'
nnoremap <silent> <leader>z :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Redefine Rg command to allow rg arguments to pass through
" such as `-tyaml` for yaml files or `-F` for literal strings
" TODO: Temporarily replace fzf#vim#with_preview() with {}
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.(<q-args>),
  \   1, {}, <bang>0)

" NERDTree
let g:NERDTreeWinSize=50
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <M-e> :NERDTreeFind<CR>

" Lightline
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" coc.nvim settings
let g:coc_global_extensions = ['coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html',
  \ 'coc-json', 'coc-prettier', 'coc-rust-analyzer', 'coc-angular', 'coc-styled-components',
  \ 'coc-snippets']
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
