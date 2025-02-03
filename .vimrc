" Vim settings
let mapleader = ","
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" General settings
set number
set clipboard=unnamed
" set relativenumber
set tabstop=4	" Number of spaces that a <Tab> in the file counts for
set shiftwidth=4	" Number of spaces to use for each step of (auto)indent
set softtabstop=4	" Number of spaces that a <Tab> in the file counts for
set wrap	" Wrap long lines
set hlsearch	" Highlight search results
set expandtab	" Use spaces instead of tabs
set smartindent	" Automatically insert the correct indentation
set autoindent	" Copy the indentation from the previous line
set smarttab	" Use the appropriate number of spaces to insert a <Tab>
set backspace=indent,eol,start	" Allow backspacing over everything in insert mode
syntax on	" Enable syntax highlighting
set mouse=a	" Enable mouse support
set cursorline    " Highlight the current line
set ignorecase	" Ignore case when searching
set showmatch	" Show matching brackets
set encoding=utf-8	" Set encoding to UTF-8
set incsearch	" Incremental search
set wildmenu	" Enhanced command line completion
set wildmode=longest:full,full	" Enhanced command line completion

" Clipboard mappings
vmap <C-c> "+y
nnoremap <C-v> "+p
inoremap <C-v> <C-r>+

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
" Python
Plug 'davidhalter/jedi-vim'
Plug 'preservim/nerdtree'
" GH Copilot
Plug 'github/copilot.vim'
" markdown
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Key mappings
" Toggle NERDTree with Ctrl+n
nnoremap <C-n> :NERDTreeToggle<CR>

" Toggle GitHub Copilot on and off
nnoremap <leader>cc :Copilot disable<CR>
nnoremap <leader>ce :Copilot enable<CR>

function! CopilotStatus()abort
    return exists('*copilot#Enabled') && copilot#Enabled() ? 'enabled' : 'disabled'
endfunction

set statusline+=%{CopilotStatus()}

" Use jj to escape insert mode
inoremap jj <Esc>

" Use fzf to search for files - fuzzy
nnoremap <C-p> :FZF<CR>

" Persistent undo, this preserves undo history between sessions
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undodir
endif

" Custom status line
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" Spell checking for text files
autocmd FileType text,markdown setlocal spell spelllang=en_us

" Automatically remove trailing whitespace on save for certain file types
autocmd FileType python,javascript,html,css,markdown autocmd BufWritePre <buffer> %s/\s\+$//e

" Splits open at the bottom and right side of the screen
set splitbelow
set splitright

" File-specific indentation for YAML files
autocmd FileType yaml,markdown,html,css,javascript setlocal ts=2 sts=2 sw=2 expandtab

