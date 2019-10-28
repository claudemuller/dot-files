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
Plug 'junegunn/fzf.vim'                          " fuzzy finder plugin using fzf :req: fzf,ripgrep/silver-searcher
Plug 'wincent/ferret'                            " fuzzy search and multiple file replace plugin                                     
Plug 'tpope/vim-fugitive'                        " git plugin
Plug 'mhinz/vim-signify'                         " plugin to show what has changed according to git history
Plug 'tpope/vim-surround'                        " surround text with char plugin
Plug 'deviantfero/wpgtk.vim'                     " wpgtk colour scheme for vim

" Coding plugins
Plug 'neomake/neomake'                           " plugin to asynchronously make/run code to detect issues
Plug 'SirVer/ultisnips'                          " very good and fast snippet engine
Plug 'honza/vim-snippets'                        " set of snippets for code plugin
Plug 'ncm2/ncm2'                                 " autocompletion engine plugin 
Plug 'roxma/nvim-yarp'                           " required by ncm2
Plug 'tpope/vim-commentary'                      " commenting plugin
Plug 'majutsushi/tagbar'                         " method and class outline/browser plugin
Plug 'joonty/vdebug'                             " debugger plugin
" Plug 'tobyS/vmustache'                         " an implementation of the Mustache template system in VIMScript <- requires setup

" .php Plugins
Plug 'StanAngeloff/php.vim'                      " improved .php syntax highlighting plugin
Plug 'stephpy/vim-php-cs-fixer'                  " plugin that reformats .php code based on PSR1/PSR2 upon event
Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}    " autocompletion plugin for .php
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
" | User Config                                                                                                                                              |
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
let g:mapleader = '\'                                       " set leader to ,


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | User Config                                                                                                                                              |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
map <C-b> :b#<CR>


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

" fzf config
map <leader>ff :FZF<CR>
map <leader>ft :Tags<CR>
map <leader>fm :BTags<CR>
map <leader>fb :Buffers<CR>
map <leader>fs :Ag<CR>

" vim-miniyank config
map <leader>p <Plug>(miniyank-cycle)

" ncm2-(phpactor?) config
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" neomake config
call neomake#configure#automake('nrwi', 500)

" lightline config

" phpactor config
" Include use statement
"nmap <Leader>u :call phpactor#UseAdd()<CR>
" Invoke the context menu
"nmap <Leader>pc :call phpactor#ContextMenu()<CR>
" Invoke the navigation menu
"nmap <Leader>nn :call phpactor#Navigate()<CR>
" Goto definition of class or class member under the cursor
"nmap <Leader>o :call phpactor#GotoDefinition()<CR>
" Show brief information about the symbol under the cursor
nmap <Leader>D :call phpactor#Hover()<CR>
" Transform the classes in the current file
"nmap <Leader>tt :call phpactor#Transform()<CR>
" Generate a new class (replacing the current file)
"nmap <Leader>cc :call phpactor#ClassNew()<CR>
" Extract expression (normal mode)
"nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" Extract expression from selection
"vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
" Extract method from selection
"vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>


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


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Autorun commands                                                                                                                                         |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" generate ctags on .php save
autocmd BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &  

" show active file in NERDTree when opening a file
" returns true iff is NERDTree open/active
function! NtIsOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! NtSyncTree()
  if &modifiable && NtIsOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufEnter * call NtSyncTree()

