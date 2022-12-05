" ## customized [2022.08.31 c4augustus]
set expandtab
set hls
set noautoindent
set nocindent
set nowrap
set ruler
set runtimepath=$VIMRUNTIME,~/z/v/adjuncta/config/prog/vim
set tabstop=2
set vb t_vb=
syntax on
colorscheme wf_arc
autocmd FileType c colorscheme anotherdark
autocmd FileType cpp colorscheme anotherdark
autocmd FileType clojure colorscheme candyman
autocmd FileType cs colorscheme cobaltish
autocmd FileType css colorscheme coda
autocmd FileType elixir colorscheme earendel
"autocmd FileType elixir colorscheme ego
"autocmd FileType elixir colorscheme ekinivim
autocmd FileType erlang colorscheme ecostation
autocmd FileType fsharp colorscheme navajo-night
"autocmd FileType fsharp colorscheme no_quarter
autocmd FileType git colorscheme darth
  " ^ shows trailing spaces
autocmd FileType groovy colorscheme antares
  " ^ black, gray, ash, green, orange
autocmd FileType html colorscheme fokus
autocmd FileType idris colorscheme onedark
"autocmd FileType idris colorscheme colorsbox-steighties
autocmd FileType javascript colorscheme CandyPaper-unblack
"autocmd FileType javascript colorscheme kib_darktango
autocmd FileType java colorscheme jellybeans
  " ^ black, off-white, dusty-blue, orange, sand, rust, baby-blue
autocmd FileType json colorscheme carrot
autocmd FileType kotlin colorscheme darkslategray
"autocmd FileType kotlin colorscheme darkburn
autocmd FileType markdown colorscheme marklar
autocmd FileType python colorscheme breeze
"autocmd FileType python colorscheme Dark
"autocmd FileType python colorscheme darkbone
"autocmd FileType python colorscheme obsidian2
autocmd FileType ruby colorscheme Revolution
  " ^ midnight-blue, white, sky-blue, moccasin, dark-sea-green
autocmd FileType rust colorscheme zenburn
"autocmd FileType rust colorscheme desertEx
"autocmd FileType rust colorscheme nefertiti
autocmd FileType sass colorscheme asmdev
autocmd FileType scss colorscheme asmdev
autocmd FileType sh colorscheme shobogenzo
autocmd FileType swift colorscheme sierra
"autocmd FileType swift colorscheme sourcerer
autocmd FileType toml colorscheme tabula
autocmd FileType yaml colorscheme vilight
autocmd FileType xml colorscheme anderson
"autocmd FileType xml colorscheme watermark
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
