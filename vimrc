" General
colo codedark
syntax on

set number	            " Show line numbers
set linebreak	        " Break lines at word (requires Wrap lines)
set showbreak=+++ 	    " Wrap-broken line prefix
set textwidth=100	    " Line wrap (number of cols)
set showmatch	        " Highlight matching brace
set errorbells	        " Beep or flash screen on errors
set visualbell	        " Use visual bell (no beeping)
 
set hlsearch	        " Highlight all search results
set smartcase	        " Enable smart-case search
set ignorecase	        " Always case-insensitive
set incsearch	        " Searches for strings incrementally
 
set autoindent	        " Auto-indent new lines
set expandtab	        " Use spaces instead of tabs
set shiftwidth=4	    " Number of auto-indent spaces
set smartindent	        " Enable smart-indent
set smarttab	        " Enable smart-tabs
set softtabstop=4	    " Number of spaces per Tab

silent !mkdir $HOME/.vim/tmp > /dev/null 2>&1 "create backup dir if not exists
set backup              " tell vim to keep a backup file
set backupdir^=$HOME/.vim/tmp// " tell vim where to put its backup files
set writebackup         " make backup before overwriting the current buffer
set backupcopy=yes      " overwrite the original backup file
set directory^=$HOME/.vim/tmp//   " tell vim where to put swap files

" Advanced
set ruler	            " Show row and column ruler information 
set undolevels=1000	    " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
