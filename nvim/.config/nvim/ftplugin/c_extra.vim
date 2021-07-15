" nmap ,s :find %:t:r.c<CR>
" nmap ,S :sf %:t:r.c<CR>
" nmap ,h :find %:t:r.h<CR>
" nmap ,H :sf %:t:r.h<CR>
function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cpp")
	let filename = trim(expand("%:p"), ".cpp") . ".h"
	execute 'vs' filename
  else
	let filename = trim(expand("%:p"), ".h") . ".cpp"
	execute 'vs' filename
  endif
endfunction
nmap <leader>ss :call SwitchSourceHeader()<CR>
