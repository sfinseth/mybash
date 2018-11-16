set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'

call vundle#end()

filetype plugin indent on

:let mapleader=' '
let g:aurline_powerline_fonts=1
set clipboard=unnamed

" Show existing tab with 4 spaces width
set tabstop=2
" When indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

set nu
set rnu

" Better splitting
set splitbelow
set splitright
" Enable folding
set foldmethod=indent
set foldlevel=99
" Now we fold with spacebar
nnoremap <space> za

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

autocmd BufRead,BufNewFile silent! *.py 
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix

autocmd BufRead,BufNewFile silent! *.js, *.html, *.css
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2

set encoding=utf-8

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
let g:syntastic_yaml_checkers = ['yamllint']
syntax on

:command-bang Q q<bang>
:command-bang W w<bang>
:command-bang Wq wq<bang>
:command-bang WQ wq<bang>
