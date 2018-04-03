" Vim color file

" cool help screens
" :he group-name
" :he highlight-font
" :he highlight-groups
" :he highlight-gui
" :he cterm-colors
" :he win32-colors

" set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="wf_arc"

hi Normal       guifg=black             guibg=#D0C8B0

" highlight groups
"hi Cursor       guifg=NONE              guibg=yellow
hi Cursor       guifg=NONE              guibg=green
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit    guifg=grey50            guibg=#c2bfa5       gui=none
hi Folded       guifg=gold              guibg=grey30
hi FoldColumn   guifg=tan               guibg=grey30
hi IncSearch    guifg=slategrey         guibg=khaki
"hi LineNr      guifg=black             guibg=white
hi ModeMsg      guifg=yellow
hi MoreMsg      guifg=SeaGreen
hi NonText      guifg=gray30            guibg=grey60
hi Question     guifg=red
hi Search                               guibg=goldenrod
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guifg=black             guibg=darkkhaki     gui=none
hi StatusLineNC guifg=black             guibg=grey50        gui=none
hi Title        guifg=indianred
hi Visual       guibg=white
"hi VisualNOS
hi WarningMsg   guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment       guifg=gray40
hi Constant      guifg=olivedrab
hi Identifier    guifg=peru
hi Statement     guifg=firebrick                            gui=NONE
hi PreProc       guifg=chocolate
hi Type          guifg=sienna                               gui=NONE
hi Special       guifg=indianred
"hi Underlined
hi Ignore        guifg=grey40
"hi Error
hi Todo          guifg=white            guibg=NONE

"vim: sw=4
