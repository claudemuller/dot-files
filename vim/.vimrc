set nocompatible
filetype off

" Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
"set rtp+=~/vimfiles/bundle/Vundle.vim                  " for Windows
"let path='~/vimfiles/bundle'                           " for Windows
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'leafgarland/typescript-vim'
Plugin 'scrooloose/nerdtree'
" http://www.vim.org/scripts/script.php?script_id=3359  " Figlet

" Colourschemes
Plugin 'w0ng/vim-hybrid'
Plugin 'arcticicestudio/nord-vim'

call vundle#end()

filetype plugin indent on
syntax on
set fileformat=unix

set t_ut=
set t_Co=256
set background=dark
let g:nord_cursor_line_number_background=1
let g:powerline_pycmd='py3'
let g:nord_italic_comments=1
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

colorscheme nord
set number
set foldenable
set incsearch
set hlsearch
set fileencoding=utf-8
set encoding=utf-8
set backspace=indent,eol,start
set smartcase
set showmatch
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set cursorline
set visualbell
set laststatus=2
set relativenumber
set clipboard=unnamedplus

" Indenting
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Remove GUI stuff
set guioptions-=r
set guioptions-=L
set guioptions-=T
set guioptions-=m

" Disable arrow keys
no <up> <Nop>
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>

let mapleader=','

" Markdown extension .md
au BufRead,BufNewFile *.md set filetype=markdown

" .json extension
au BufRead,BufNewFile *.json set filetype=javascript

" Ruby Vagrant file
au BufRead,BufNewFile Vagrantfile set filetype=ruby

" Puppet file
au BufRead,BufNewFile *.pp set filetype=puppet

" EJS file
au BufRead,BufNewFile *.ejs set filetype=html

" SCSS/CSS two space indent
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2

" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" NERDTree config
map <leader>N :NERDTreeToggle<CR>
" Show hidden files
let NERDTreeShowHidden=1

" netrw settings
let g:netrw_liststyle=3
let g:netrw_preview=1

" CtrlP browse in buffer list
map <C-P><C-P> :CtrlPBuffer<CR>

nmap <leader>n :noh<CR>

" Removes trailing spaces
function! TrimWhiteSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//eg
    call cursor(l, c)
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Set region to British English
set spelllang=en_gb

" Copy and Paste (Mac)
"vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Powerline for prettifying command line
"set rtp+=/usr/lib/python3.7/site-packages/powerline/bindings/vim/
set guifont=Source\ Code\ Pro\ for\ Powerline

