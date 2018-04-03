" ## customized [2018.04.01 c4augustus]
set expandtab
set hls
set noautoindent
set nocindent
set nowrap
set ruler
set runtimepath=$VIMRUNTIME,~/v/adjuncta/config/prog/vim
set tabstop=2
set vb t_vb=
syntax on
colorscheme wf_arc
autocmd FileType cpp colorscheme anotherdark
  " ^ charc, white, orange, gold rust, salmon
"autocmd FileType git colorscheme alduin
autocmd FileType git colorscheme darth
  " ^ shows trailing spaces
autocmd FileType groovy colorscheme antares
  " ^ black, gray, ash, green, orange
"colorscheme DarkDefault
autocmd FileType java colorscheme jellybeans
  " ^ black, off-white, dusty-blue, orange, sand, rust, baby-blue
"autocmd FileType kotlin colorscheme darkburn
autocmd FileType kotlin colorscheme darkslategray
"autocmd FileType kotlin colorscheme desert
"autocmd FileType kotlin colorscheme desertEx
"autocmd FileType kotlin colorscheme kalisi
"autocmd FileType kotlin colorscheme kellys
"autocmd FileType kotlin colorscheme kolor
autocmd FileType markdown colorscheme marklar
"autocmd FileType python colorscheme Blue2
"autocmd FileType python colorscheme Dark
"autocmd FileType python colorscheme darkbone
"autocmd FileType python colorscheme obsidian2
autocmd FileType python colorscheme onedark
autocmd FileType ruby colorscheme revolution
  " ^ midnight-blue, white, sky-blue, moccasin, dark-sea-green
autocmd FileType sh colorscheme shobogenzo
autocmd FileType swift colorscheme sierra
"autocmd FileType swift colorscheme sourcerer
autocmd FileType yaml colorscheme yeller
autocmd FileType xml colorscheme anderson
" ## from https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()
