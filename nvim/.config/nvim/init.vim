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
"Plug 'svermeulen/vim-yoink'                      " vim register browser plugin
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
Plug '907th/vim-auto-save'                       " auto save plugin
Plug 'alvan/vim-closetag'                        " autoclose (x)html tags plugin
Plug 'jiangmiao/auto-pairs'                      " autoclose brackets, quotes and such plugin
Plug 'terryma/vim-multiple-cursors'              " multiple cursors plugin
Plug 'RRethy/vim-illuminate' 			         " autohighlight word matches when hovering on word plugin

" Coding plugins
Plug 'neomake/neomake'                           " plugin to asynchronously make/run code to detect issues
Plug 'SirVer/ultisnips'                          " very good and fast snippet engine
Plug 'honza/vim-snippets'                        " set of snippets for code plugin
"Plug 'ncm2/ncm2'                                 " autocompletion engine plugin
"Plug 'roxma/nvim-yarp'                           " required by ncm2
Plug 'scrooloose/nerdcommenter'                  " commenting plugin
Plug 'majutsushi/tagbar'                         " method and class outline/browser plugin
Plug 'joonty/vdebug'                             " debugger plugin
Plug 'dense-analysis/ale'                        " code and style syntax and problem checker
Plug 'tobyS/vmustache'                           " an implementation of the Mustache template system  - required for pdv
Plug 'ludovicchabant/vim-gutentags'              " auto ctags handling
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " code completion plugin
Plug 'SirVer/ultisnips'                          " snippet plugin

" .php plugins
Plug 'StanAngeloff/php.vim'                      " improved .php syntax highlighting plugin
Plug 'stephpy/vim-php-cs-fixer'                  " plugin that reformats .php code based on PSR1/PSR2 upon event
"Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}    " autocompletion plugin for .php
"Plug 'phpactor/ncm2-phpactor'                    " plugin to link phpfactor to ncm2
Plug 'adoy/vim-php-refactoring-toolbox'          " .php refactoring toolbox plugin
Plug 'tobyS/pdv'                                 " generates .php docblocks plugin
"Plug 'noahfrederick/vim-laravel'                " laravel plugin
Plug 'jwalton512/vim-blade'                      " blade syntax hilighting plugin
Plug 'nelsyeung/twig.vim'                        " twig syntax hilighting plugin
Plug 'arnaud-lb/vim-php-namespace'               " use statement insertion plugin
" https://github.com/squizlabs/PHP_CodeSniffer   " will make sure that .php is properly formatted
                                                 "   `composer global require "squizlabs/php_codesniffer=*"`
" https://github.com/phpstan/phpstan             " will make some guesses about types in your code based on typehints and phpDoc annotations <- requires setup
                                                 "   `composer require --dev phpstan/phpstan`
" https://phpmd.org/                             " possible bugs;  suboptimal code; overcomplicated expressions; Unused parameters, methods, properties
                                                 "   `composer require --dev phpmd/phpmd`
"Plug 'shawncplus/phpcomplete.vim'                " php autocomplete plugin - OmniComplete

" .js plugins
Plug 'othree/yajs.vim'                           " .js plugin

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
set ruler                               " show line
set cursorline                          " highlight current line
set wildmode=longest,list               " get bash-like tab completions
set cc=160                              " set an 80 column border for good coding style
filetype plugin indent on               " allows auto-indenting depending on file type
syntax on         	                    " switch syntax highlighting on
colorscheme wpgtk                       " set colour scheme to wpgtk - alternative: wpgtkAlt
let g:mapleader = '\'                   " set leader to ,
map <C-b> :b#<CR>                       " switch buffers
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
map <c-s> <esc>:w<cr>:Silent php-cs-fixer fix %:p --level=symfony<cr>
let g:elite_mode=1                      " enable elite mode, No ARRRROWWS!!!!
if get(g:, 'elite_mode')
    nnoremap <Up>    :resize +2<CR>
    nnoremap <Down>  :resize -2<CR>
    nnoremap <Left>  :vertical resize -2<CR>
    nnoremap <Right> :vertical resize +2<CR>
endif
set clipboard=unnamed,unnamedplus


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Plugins Config                                                                                                                                           |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

" nerdtree config
set rtp+=~/nvim/plugged/nerdtree/
nnoremap <leader>ne :NERDTreeToggle<CR>
"let NERDTreeWinSize=1
"unmap <leader>ci<CR>
" vim-project config
"let g:project_use_nerdtree = 1
let g:project_enable_welcome = 1
" load projects config
so ~/.config/nvim/.projects
nmap <leader><F2> :e ~/.config/nvim/.projects<CR>

" fzf config
map <leader>ff :FZF<CR>
map <leader>ft :Tags<CR>
map <leader>fm :BTags<CR>
map <leader>fb :Buffers<CR>
map <leader>fs :Ag<CR>

" vim-yoink config
"nmap <c-n> <plug>(YoinkPostPasteSwapBack)
"nmap <c-p> <plug>(YoinkPostPasteSwapForward)
"nmap p <plug>(YoinkPaste_p)
"nmap P <plug>(YoinkPaste_P)

" ncm2-(phpactor?) config
"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" neomake config
"call neomake#configure#automake('nrwi', 500)

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
"nmap <Leader>D :call phpactor#Hover()<CR>
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
"let g:phpactorOmniAutoClassImport = v:true

" vim-auto-save config
let g:auto_save = 1

" ale config
"let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_open_list = 1
"let g:ale_keep_list_window_open=0
"let g:ale_set_quickfix=0
"let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer'],
  \}
let g:ale_fix_on_save = 1

" scrooloose/nerdcommenter config
map <C-_> <leader>c<space>              " remap comment toggle to ctrl forward slash

" tobyS/pdv
let g:pdv_template_dir = $HOME . "/nvim/plugged/pdv/templates_snip"
nnoremap <buffer> <leader> <d> :call pdv#DocumentWithSnip()<CR>
let g:pdv_cfg_Author = 'Claude Müller <claude@dxt.rs>'
let g:pdv_cfg_ClassTags = ["package","author","version"]
"au BufRead,BufNewFile *.php inoremap <buffer> <C-P> :call PhpDoc()<CR>
"au BufRead,BufNewFile *.php nnoremap <buffer> <C-P> :call PhpDoc()<CR>
"au BufRead,BufNewFile *.php vnoremap <buffer> <C-P> :call PhpDocRange()<CR>

" rrethy/vim-illustrate config
hi link illuminatedWord Visual

" gutentags config
set statusline+=%{gutentags#statusline()}
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git', 'Makefile']
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" neoclide/coc config
let g:coc_global_extensions = [ 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-phpls', 'coc-js', 'coc-html', 'coc-css', 'coc-json', 'coc-python' ]
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Don't give |ins-completion-menu| messages.
set shortmess+=c
" Always show signcolumns
set signcolumn=yes
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

" Use D to show documentation in preview window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" SirVer/ultisnips
" Remap ExpandTrigger
let g:UltiSnipsExpandTrigger="<c-tab>"

" vim-php-namespace config
" automatic namespace inserting
let g:php_namespace_sort_after_insert=1
" insert use statements
autocmd FileType php inoremap <Leader>pu <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction

" expand fully qualified names
autocmd FileType php inoremap <Leader>pe <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>pe :call PhpExpandClass()<CR>
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction

" jump to definition
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" lightline config
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightLineFilename'
      \ },
      \ }
function! LightLineFilename()
  return expand('%')
endfunction

" figitive shortcuts
" conflict resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" termdebug shortcuts
nmap <silent> <leader>dr :Run<CR>
nmap <silent> <leader>db :Break<CR>
nmap <silent> <leader>dc :Clear<CR>
nmap <silent> <leader>ds :Step<CR>
nmap <silent> <leader>do :Over<CR>
nmap <silent> <leader>df :Finish<CR>
nmap <silent> <leader>de :Evaluate<CR>

" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Language Configs                                                                                                                                         |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

" .js config
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" .html config
autocmd FileType html       setlocal shiftwidth=4 tabstop=4

" .php config
autocmd FileType html       setlocal shiftwidth=4 tabstop=4


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

function! BuildAndRun()
  if filereadable("./Makefile")
    make build_and_run
  endif
endfunction
nmap <silent> <F9> :call BuildAndRun()<CR>

function! BuildAndDebug()
  if filereadable("./Makefile")
    make debug
  endif
endfunction
nmap <silent> <F10> :call BuildAndDebug()<CR> :packadd termdebug<CR> :Termdebug game<CR>

" Symfony code style for PHP
function! Symfony(...)
    let g:ultisnips_php_scalar_types = 1

    " standard phpcs config
    let g:neomake_php_phpcs_args_standard = 'PSR2'

    " php cs fixer
    let g:php_cs_fixer_php_path = "php"

    autocmd FileType php nnoremap <leader>g :call PhpCsFixerFixFile()<CR>
endfunction


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Autorun commands                                                                                                                                         |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" generate ctags on .php save
"autocmd BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" generate ctags on .js save
"autocmd BufWritePost *.js silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" show active file in NERDTree when opening a file
" returns true iff is NERDTree open/active
function! NtIsOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" calls NERDTreeFind if NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! NtSyncTree()
  if &modifiable && NtIsOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufEnter * call NtSyncTree()

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! GetCommitForSelection(lines)
    echo lines
endfunction

command! LESIGH call GetCommitForSelection([s:get_visual_selection()])
command! WTF :<C-U>GetCommitForSelection<cr>
