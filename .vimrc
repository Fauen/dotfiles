set nocompatible				" This is needed for the vimwiki package

call plug#begin()
Plug 'ap/vim-css-color'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'
Plug 'mattn/calendar-vim'
Plug 'morhetz/gruvbox'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/vim-lsp-settings'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
call plug#end()

" syntax on					" Handled by vim-plug
" filetype indent on				" Handled by vim-plug
" filetype plugin indent on			" Handled by vim-plug

" These clips helped me with LSP in vim
" https://www.youtube.com/watch?v=-aIPEOxUCUY
" https://www.youtube.com/watch?v=-aIPEOxUCUY
" Make sure to install npm and rust as well
" Plugin 'github/copilot'			" Load copilot (https://github.com/github/copilot)

let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    "nmap <buffer> gs <plug>(lsp-document-symbol-search)
    "nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    "nmap <buffer> gi <plug>(lsp-implementation)
    "nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    "nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    "nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" This section only applies if the file being edited is a yaml file
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" If you are using vim on Windows (gvim) uncomment the two options below
" :set langmenu=en_US
" :let $LANG = 'en_US'

" Set default color in the vim editor
colorscheme gruvbox

" set number		" Set line numbers visible by default
" set relativenumber	" Set relative line numbers
" set showcmd		" This will make it visual when you hit keys like <leader> (\) like in emacs
" set splitright		" Set default
" syntax on		" Set syntax highlighting on
" set hlsearch		" Set search highlighting on
" set incsearch		" Set incremental search highlight on
" set backspace=indent,eol,start
" set laststatus=2
" set noshowmode

set autoindent
set background=dark
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set hlsearch					" Set search highlighting on
set incsearch					" Set incremental search highlight on
set laststatus=2
set noshowmode
set number					" Set line numbers visible by default
set path+=**
set relativenumber				" Set relative line numbers
set scrolloff=1
set showcmd					" This will make it visual when you hit keys like <leader> (\) like in emacs
set showmatch
set smartindent
set splitright					" Set default
set wildmenu

let mapleader = " "				" map leader to Space instead of \ 

" Setting up undo, backup and swap location of files
" The trailing slashed means that the filename will be the full path
" Good when you edit files with the same name so no conflict will happen
" We also check the OS so the path is correct.
if !exists('g:env')
    if has('win64') || has('win32') || has('win16')
        let g:env = 'WINDOWS'
    else
        let g:env = 'NIX'
    endif
endif

if g:env =~ 'NIX'
	set undodir=/tmp//
	set backupdir=/tmp/
	set directory=/tmp//
endif

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
	set t_ut=
endif

" This is commands that will open up other functionalities.
nnoremap ,date :-1pu=strftime('%Y-%m-%d')<CR>A<SPACE>
nnoremap ,cal :Calendar<CR>
" nnoremap ,term :terminal ++curwin<CR>			" old map
" nnoremap ,term :vsplit | terminal<CR>

" Do it right
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Down> :echoe "Use j"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Right> :echoe "Use l"<CR>

" Rebind keys for window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Rebind keys for tab movement
nnoremap <C-w><C-l> :tabnext<CR>
nnoremap <C-w><C-h> :tabprevious<CR>
nnoremap <C-w>c :tabnew<CR>
nnoremap <C-w>- :split<CR>
nnoremap <C-w>_ :vertical split<CR>

" Rebind key for NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" General keybinds
nnoremap <silent> <ESC><ESC> <ESC>:nohlsearch<CR><ESC>
