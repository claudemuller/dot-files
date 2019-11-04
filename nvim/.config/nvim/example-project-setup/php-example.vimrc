" for vagrant docker setups - left value vagrant/docker location; right local location
let g:vdebug_options["path_maps"] = {
    \       "/mySuperProject": "/home/mySuperUser/workspace/mySuperProject"
    \}

let g:startify_bookmarks = [ 
            \ {'1': '~/workspace/mySuperProject/README.md'},
            \]

Project  'mySuperProject'
Callback 'mySuperProject', ['Symfony', 'mySuperProject']

set tags=~/dxtrs/projects/team-extension/sbt/sites/SBT-CMS/.git/tags

" set author phpdoc
let g:pdv_cfg_Author = 'Claude Müller <claude@crayon.jobs>'

function! mySuperProject(...)
    let g:vdebug_options["path_maps"] = {
    \       "/mySuperProject": "/home/mySuperUser/workspace/mySuperProject"
    \}
    PadawanStartServer
endfunction

function! Symfony(...)
    let g:ultisnips_php_scalar_types = 1

    " standard phpcs config
    let g:neomake_php_phpcs_args_standard = 'PSR2'

    " php cs fixer 
    let g:php_cs_fixer_php_path = "php"

    autocmd FileType php nnoremap <leader>g :silent :call PhpCsFixerFixFile()<CR>
endfunction

