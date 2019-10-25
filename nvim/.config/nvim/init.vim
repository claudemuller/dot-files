" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" |                                                                                                                                                          |
" |    __  __                 __  __                      ____                       ___                                                                     |
" |   /\ \/\ \               /\ \/\ \  __                /\  _`\                   /'___\ __                                                                 |
" |   \ \ `\\ \     __    ___\ \ \ \ \/\_\    ___ ___    \ \ \/\_\    ___     ___ /\ \__//\_\     __                                                         |
" |    \ \ , ` \  /'__`\ / __`\ \ \ \ \/\ \ /' __` __`\   \ \ \/_/_  / __`\ /' _ `\ \ ,__\/\ \  /'_ `\                                                       |
" |     \ \ \`\ \/\  __//\ \L\ \ \ \_/ \ \ \/\ \/\ \/\ \   \ \ \L\ \/\ \L\ \/\ \/\ \ \ \_/\ \ \/\ \L\ \                                                      |
" |      \ \_\ \_\ \____\ \____/\ `\___/\ \_\ \_\ \_\ \_\   \ \____/\ \____/\ \_\ \_\ \_\  \ \_\ \____ \                                                     |
" |       \/_/\/_/\/____/\/___/  `\/__/  \/_/\/_/\/_/\/_/    \/___/  \/___/  \/_/\/_/\/_/   \/_/\/___L\ \                                                    |
" |                                                                                               /\____/                                                    |
" |                                                                                               \_/__/                                                     |
" |                                                                                                                                                          |
" |                                                                                                                                                          |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Install Plugins                                                                                                                                          |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

call plug#begin('~/nvim/plugged')

" General Plugins
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}  " file explorer plugin
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'bfredl/nvim-miniyank'                      " vim register browser plugin
Plug 'itchyny/lightline.vim'                     " status line plugin
Plug 'tpope/vim-abolish'                         " substitution plugin that handles plurals, case and underscores
Plug 'amiorin/vim-project'                       " project management plugin
Plug 'mhinz/vim-startify'                        " startup screen plugin
Plug 'neomake/neomake'                           " plugin to asynchronously make/run code
Plug 'junegunn/fzf.vim'                          " fuzzy finder plugin using fzf :req: fzf,ripgrep
Plug 'wincent/ferret'                            " fuzzy search and multiple file replace plugin                                     
Plug 'tpope/vim-fugitive'                        " git plugin
Plug 'mhinz/vim-signify'                         " plugin to show what has changed according to git history
Plug 'tpope/vim-surround'                        " surround text with char plugin
Plug 'deviantfero/wpgtk.vim'                     " wpgtk colour scheme for vim

" Coding plugins
Plug 'SirVer/ultisnips'                          " very good and fast snippet engine
Plug 'honza/vim-snippets'                        " set of snippets for code plugin
Plug 'ncm2/ncm2'                                 " autocompletion engine plugin 
Plug 'tpope/vim-commentary'                      " commenting plugin
Plug 'majutsushi/tagbar'                         " method and class outline/browser plugin
Plug 'joonty/vdebug'                             " debugger plugin
" Plug 'tobyS/vmustache'                         " an implementation of the Mustache template system in VIMScript <- requires setup

" .php Plugins
Plug 'StanAngeloff/php.vim'                      " improved .php syntax highlighting plugin
Plug 'stephpy/vim-php-cs-fixer'                  " plugin that reformats .php code based on PSR1/PSR2 upon event
Plug 'phpactor/phpactor'                         " autocompletion plugin for .php
Plug 'phpactor/ncm2-phpactor'                    " plugin to link phpfactor to ncm2
Plug 'adoy/vim-php-refactoring-toolbox'          " .php refactoring toolbox plugin
Plug 'tobyS/pdv'                                 " generates .php docblocks plugin
" https://github.com/squizlabs/PHP_CodeSniffer   " will make sure that .php is properly formatted
                                                 "   `composer global require "squizlabs/php_codesniffer=*"`
" https://github.com/phpstan/phpstan             " will make some guesses about types in your code based on typehints and phpDoc annotations <- requires setup
                                                 "   `composer require --dev phpstan/phpstan`
" https://phpmd.org/                             " possible bugs;  suboptimal code; overcomplicated expressions; Unused parameters, methods, properties 
                                                 "   `composer require --dev phpmd/phpmd`

call plug#end()


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Apply Settings                                                                                                                                           |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

set showmatch                           " show matching brackets.
set mouse=v                             " middle-click paste with mouse
set hlsearch                            " highlight search results
set incsearch                           " incremental search
set tabstop=4                           " number of columns occupied by a tab character
set softtabstop=4                       " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                           " converts tabs to white space
set shiftwidth=4                        " width for autoindents
set autoindent                          " indent a new line the same amount as the line just typed
set number                              " add line numbers
set relativenumber                      " set relative numbering
set ruler                               " show line at cursor
set wildmode=longest,list               " get bash-like tab completions
set cc=160                              " set an 80 column border for good coding style
filetype plugin indent on               " allows auto-indenting depending on file type
syntax on         	                    " switch syntax highlighting on
colorscheme wpgtk                       " set colour scheme to wpgtk - alternative: wpgtkAlt
let g:mapleader = ','                                       " set leader to ,


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Plugins Config                                                                                                                                           |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

" ripgrep config

noremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>

autocmd VimEnter * command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" nerdtree config
set rtp+=~/nvim/plugged/nerdtree/
map <C-n> :NERDTreeToggle<CR>

" vim-project config

let g:project_use_nerdtree = 1
let g:project_enable_welcome = 1
" load projects config
so ~/.config/nvim/.projects
nmap <leader><F2> :e ~/.config/nvim/.projects<cr>


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Keymappings                                                                                                                                              |
" | -----------                                                                                                                                              |
" |                                                                                                                                                          |
" | nnoremap: normal mode keymapping                                                                                                                         |
" | inoremap: insert mode keymapping                                                                                                                         |
" | vnoremap: visual mode keymapping                                                                                                                         |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

" nnoremap <leader>s :set invspell<CR>                      " when invoking an Ex command <CR> is needed to complete command
" inoremap <leader>d <C-R>=strftime("%Y-%m-%dT%H:%M")<CR>   " <C-R>= is used to insert output at cursor loc
" 


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Autorun commands                                                                                                                                         |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" generate ctags on .php save
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &  

