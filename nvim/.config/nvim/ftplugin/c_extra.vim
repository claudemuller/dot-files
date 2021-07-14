" nmap ,s :find %:t:r.c<CR>
" nmap ,S :sf %:t:r.c<CR>
" nmap ,h :find %:t:r.h<CR>
" nmap ,H :sf %:t:r.h<CR>
function! SwitchSourceHeader()
  "update!
  if (expand ("%:e") == "cpp")
	" echo "fdfind '^" . bufname("%"):t:r.h . "$'"
	" echo system("fdfind '^" . bufname("%"):t:r.h . "$'")
	" if (system("fdfind '^main.cpp$'"))
		vs %:t:r.h
	" endif
  else
	vs %:t:r.cpp
  endif
endfunction
nmap <leader>ss :call SwitchSourceHeader()<CR>
