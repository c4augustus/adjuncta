" ## customized [2023.06.24 c4augustus]
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
"
" ## TRAILING WHITESPACE
set list listchars=trail:▪,extends:>
" EXAMPLE TRAILING WHITESPACE:      
" ## from https://stackoverflow.com/a/13795287/8022360
" ## FYI, the red background is not showing up
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
" ## DISABLED BECAUSE IT GENERATES TOO MANY GIT DIFFS
"autocmd BufWritePre * :call TrimWhiteSpace()
"
autocmd FileType aboa colorscheme aboacores
"autocmd FileType aboa colorscheme clarity
"autocmd FileType aboa colorscheme penultimate
"autocmd FileType aboa colorscheme rdark
"autocmd FileType aboa colorscheme sorcerer
"autocmd FileType aboa colorscheme sourcerer
autocmd FileType apl colorscheme atom
autocmd FileType c colorscheme anotherdark
autocmd FileType cpp colorscheme mod8
"autocmd FileType cpp colorscheme anotherdark
"autocmd FileType cpp colorscheme oceanblack
"autocmd FileType cpp colorscheme oceandeep
autocmd FileType clojure colorscheme candyman
autocmd FileType cs colorscheme cobaltish
autocmd FileType css colorscheme coda
autocmd FileType diff colorscheme darth
autocmd FileType elixir colorscheme earendel
"autocmd FileType elixir colorscheme ego
"autocmd FileType elixir colorscheme ekinivim
autocmd FileType erlang colorscheme obsidian2
"autocmd FileType erlang colorscheme ecostation
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
autocmd FileType markdown colorscheme marklar
autocmd FileType objcpp colorscheme sandydune
autocmd FileType python colorscheme breeze
"autocmd FileType python colorscheme darkbone
autocmd FileType ruby colorscheme Revolution
  " ^ midnight-blue, white, sky-blue, moccasin, dark-sea-green
autocmd FileType rust colorscheme zenburn
"autocmd FileType rust colorscheme desertEx
"autocmd FileType rust colorscheme nefertiti
autocmd FileType sass colorscheme asmdev
autocmd FileType scheme colorscheme chance-of-storm
autocmd FileType scss colorscheme asmdev
autocmd FileType sh colorscheme shobogenzo
autocmd FileType swift colorscheme sierra
"autocmd FileType swift colorscheme sourcerer
autocmd FileType toml colorscheme tabula
autocmd FileType yaml colorscheme vilight
autocmd FileType xml colorscheme anderson
"autocmd FileType xml colorscheme watermark
