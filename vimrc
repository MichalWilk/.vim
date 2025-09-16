" ================= Basic settings =================
set nocompatible
set encoding=utf-8
set fileencoding=utf-8

" UI
set number
set cursorline
set showmatch
set ruler
set showbreak=+++
set errorbells
set visualbell
set mouse=a
set clipboard=unnamedplus
set wildmode=longest,list
set colorcolumn=80
set spell
set signcolumn=yes

" Splits
set splitbelow
set splitright

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch

" Indentation
set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start

" Backup, swap, undo
set backup
set backupdir^=$HOME/.vim/tmp/backup//
set writebackup
set backupcopy=yes
set directory^=$HOME/.vim/tmp/swap//
set undolevels=10000
set undofile
set undodir=$HOME/.vim/tmp/undo//

silent! !mkdir -p $HOME/.vim/tmp/backup
silent! !mkdir -p $HOME/.vim/tmp/undo
silent! !mkdir -p $HOME/.vim/tmp/swap

" Leader key
let mapleader = ","

" ================= Cursor style =================
let &t_SI.="\e[5 q"
let &t_SR.="\e[3 q"
let &t_EI.="\e[1 q"

" ================= Plugins =================
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()

" ================= Colorscheme =================
if has('gui_running')
  " GVim GUI
  set background=dark
else
  " Terminal
  set termguicolors
  set background=dark
endif
colorscheme gruvbox

" ================= NERDTree =================
let NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && &buftype != 'terminal' | NERDTree | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ================= Rust =================
let g:rustfmt_autosave = 1

function! CargoRun(cmd)
  let l:manifest = findfile('Cargo.toml', '.;')
  if empty(l:manifest)
    echo "Cargo.toml not found!"
    return
  endif
  " Open a split terminal and run cargo
  execute 'belowright split | resize 15 | terminal ' . a:cmd . ' --manifest-path ' . fnameescape(l:manifest)
endfunction

" ================= CoC =================
let g:coc_global_extensions = [
      \ 'coc-rust-analyzer',
      \ 'coc-tsserver',
      \ 'coc-omnisharp',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-pairs',
      \ 'coc-yank',
      \ 'coc-snippets'
      \ ]

inoremap <expr> <TAB>  coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <expr> <CR>   coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" ================= ALE =================
let g:ale_disable_lsp = 1
let g:ale_linters = {'rust': ['cargo']}
let g:ale_fixers = {'rust': ['rustfmt','remove_trailing_lines','trim_whitespace']}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0

" ================= Key mappings =================
" General
map Q gq
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h :nohlsearch<CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" CargoRun
nnoremap <leader>r  :call CargoRun('cargo run')<CR>
nnoremap <leader>rr :call CargoRun('cargo run --release')<CR>
tnoremap <leader>x <C-\><C-n>:q<CR>
tnoremap <leader>q <C-\><C-n>:bd!<CR>
