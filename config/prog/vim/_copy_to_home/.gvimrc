" [2024.03.01 c4augustus]
set columns=80
if has("gui_gtk2") || has("gui_gtk3")
  set guifont=LucidaTypewriter\ Bold\ 10
elseif has("gui_macvim")
  " usable fonts for APL BQN (but diamond is too small)
  set guifont=Menlo:h16
elseif has("gui_win32")
  " usable fonts for APL BQN
  "set guifont=BQN386 ### NOT SUPPORTED BY gVim on WINDOWS
  "set guifont=MS_Gothic:h14:b:cANSI:qDRAFT
  set guifont=DejaVu_Sans_Mono:h12:b:cANSI:qDRAFT
else
  echo "unrecognized GUI, not setting guifont"
endif
