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
Plug 'tpope/vim-abolish'                         " substitution plugin that handles plurals, case and underscores
Plug 'junegunn/fzf.vim'                          " fuzzy finder plugin using fzf :req: fzf,ripgrep/silver-searcher
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'wincent/ferret'                            " fuzzy search and multiple file replace plugin
Plug 'tpope/vim-fugitive'                        " git plugin
Plug 'mhinz/vim-signify'                         " plugin to show what has changed according to git history
Plug 'tpope/vim-surround'                        " surround text with char plugin
Plug 'deviantfero/wpgtk.vim'                     " wpgtk colour scheme for vim
"Plug '907th/vim-auto-save'                       " auto save plugin
Plug 'alvan/vim-closetag'                        " autoclose (x)html tags plugin
Plug 'jiangmiao/auto-pairs'                      " autoclose brackets, quotes and such plugin
Plug 'terryma/vim-multiple-cursors'              " multiple cursors plugin
Plug 'RRethy/vim-illuminate' 			         " autohighlight word matches when hovering on word plugin
Plug 'vim-airline/vim-airline'
Plug 'robertbasic/vim-hugo-helper'

" Coding plugins
Plug 'neomake/neomake'                           " plugin to asynchronously make/run code to detect issues
Plug 'scrooloose/nerdcommenter'                  " commenting plugin
Plug 'majutsushi/tagbar'                         " method and class outline/browser plugin
"Plug 'vim-vdebug/vdebug'                         " debugger plugin
Plug 'puremourning/vimspector'
Plug 'janko/vim-test'                            " unit testing wrapper
"Plug 'neoclide/coc.nvim', {'branch': 'release'}  " code completion plugin
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-tsserver'
"Plug 'SirVer/ultisnips'                          " snippet plugin

" .js plugins
Plug 'othree/yajs.vim'                           " .js plugin

" V plugins
Plug 'ollykel/v-vim'

" Go plugins
Plug 'fatih/vim-go'

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
set cc=160                              " set an 160 column border for good coding style
filetype plugin indent on               " allows auto-indenting depending on file type
syntax on         	                    " switch syntax highlighting on
colorscheme wpgtk                       " set colour scheme to wpgtk - alternative: wpgtkAlt
hi! Normal ctermbg=NONE
set clipboard=unnamed,unnamedplus
let g:airline_powerline_fonts = 1

let g:mapleader = '\'                   " set leader to ,
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

let g:elite_mode=1                      " enable elite mode, No ARRRROWWS!!!!
if get(g:, 'elite_mode')
    nnoremap <Up>    :resize +2<CR>
    nnoremap <Down>  :resize -2<CR>
    nnoremap <Left>  :vertical resize -2<CR>
    nnoremap <Right> :vertical resize +2<CR>
endif

" Set make command for .v
autocmd FileType v setlocal makeprg=vet\ run\ %
" Set make command for .go
autocmd FileType go setlocal makeprg=go\ run\ %

" Remap navigation commands
map <C-S-M-h> <C-O>
noremap <C-S-M-l> <C-I>


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Plugins Config                                                                                                                                           |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

" pathogen config
execute pathogen#infect()
call pathogen#helptags()

" nerdtree config
set rtp+=~/nvim/plugged/nerdtree/

" fzf config
map <leader>ff :FZF<CR>
map <C-F> :FZF<CR>
map <leader>ft :Tags<CR>
map <C-T> :Tags<CR>
map <leader>fm :BTags<CR>
map <leader>fb :Buffers<CR>
map <C-B> :Buffers<CR>
map <leader>fs :Ag<CR>

" vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEvallet g:vimspector_install_gadgets = [ 'vscode-node-debug2' ]

function! JestStrategySingle(cmd)
    let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
    call vimspector#LaunchWithSettings( { 'configuration': 'jest', 'TestName': testName } )
endfunction
function! JestStrategyAll(cmd)
    call vimspector#LaunchWithSettings( { 'configuration': 'jestAll' } )
endfunction

let g:test#custom_strategies = {'jest': function('JestStrategySingle'), 'jestAll': function('JestStrategyAll')}
nnoremap <leader>dd :TestNearest -strategy=jest<CR>
nnoremap <leader>dh :TestFile -strategy=jestAll<CR>

" vim-auto-save config
let g:auto_save = 1

" scrooloose/nerdcommenter config
map <C-_> <leader>c<space>              " remap comment toggle to ctrl forward slash

" rrethy/vim-illustrate config
hi link illuminatedWord Visual

" neoclide/coc config
let g:coc_global_extensions = [ 'coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-phpls', 'coc-html', 'coc-css', 'coc-json', 'coc-python', 'coc-tsserver' ]
set nobackup
set nowritebackup
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

" jump to definition
nmap <silent> <leader>cd <Plug>(coc-definition)
map <c-h> <Plug>(coc-definition)
nmap <silent> <leader>ct <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

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

" figitive shortcuts
" conflict resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" termdebug shortcuts
"nmap <silent> <leader>dr :Run<CR>
"nmap <silent> <leader>db :Break<CR>
"nmap <silent> <leader>dc :Clear<CR>
"nmap <silent> <leader>ds :Step<CR>
"nmap <silent> <leader>do :Over<CR>
"nmap <silent> <leader>df :Finish<CR>
"nmap <silent> <leader>de :Evaluate<CR>


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
"nmap <silent> <F9> :make<CR>

function! BuildAndDebug()
  if filereadable("./Makefile")
    make debug
  endif
endfunction
"nmap <silent> <F10> :call BuildAndDebug()<CR> :packadd termdebug<CR> :Termdebug game<CR>


" +----------------------------------------------------------------------------------------------------------------------------------------------------------+
" | Autorun commands                                                                                                                                         |
" +----------------------------------------------------------------------------------------------------------------------------------------------------------+

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
