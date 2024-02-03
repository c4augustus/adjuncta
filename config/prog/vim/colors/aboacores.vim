" Copyright 2023 Christopher Augustus
"
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.
"
" ViM colors for the Aboa programming language
" [cores de ViM para a linguaguem de programação Aboa]
"
let g:colors_name = "aboacores"
"
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
"
" aboa invented names [nomes inventado]
hi BooleanFalse     gui=NONE      guibg=NONE      guifg=#aa6644
hi BooleanTrue      gui=NONE      guibg=NONE      guifg=#66aa44
"
" ViM builtin names [nomes internos]
" NOTE: all the colors with gui=italic are those not yet decided
"       [todos os cores com gui=italic são aquelos que ainda não foram decididos]
hi Boolean          gui=NONE      guibg=NONE      guifg=#77aaaa
hi Character        gui=NONE      guibg=#444444   guifg=#ffdd77
hi ColorColumn      gui=italic    guibg=NONE      guifg=#ffffff
hi Comment          gui=NONE      guibg=NONE      guifg=#888888
hi Conceal          gui=italic    guibg=NONE      guifg=#ffffff
hi Constant         gui=NONE      guibg=NONE      guifg=#77aaaa
hi Cursor           gui=NONE      guibg=#4466bb   guifg=NONE
hi CursorColumn     gui=italic    guibg=NONE      guifg=#ffffff
hi CursorLine       gui=italic    guibg=NONE      guifg=#ffffff
hi CursorLineFold   gui=italic    guibg=NONE      guifg=#ffffff
hi CursorLineNr     gui=italic    guibg=NONE      guifg=#ffffff
hi CursorLineSign   gui=italic    guibg=NONE      guifg=#ffffff
hi Debug            gui=italic    guibg=NONE      guifg=#ffffff
hi Delimiter        gui=NONE      guibg=NONE      guifg=#997755
hi DiffAdd          gui=italic    guibg=NONE      guifg=#00ff00
hi DiffChange       gui=italic    guibg=NONE      guifg=#ffff00
hi DiffDelete       gui=italic    guibg=NONE      guifg=#ff0000
hi DiffText         gui=italic    guibg=NONE      guifg=#00ffff
hi Directory        gui=italic    guibg=NONE      guifg=#ffffff
hi EndOfBuffer      gui=NONE      guibg=#282828   guifg=#888888
hi Error            gui=NONE      guibg=#553333   guifg=#ff7755
hi ErrorMsg         gui=NONE      guibg=#553333   guifg=#ff7755
hi FoldColumn       gui=italic    guibg=NONE      guifg=#ffffff
hi Folded           gui=italic    guibg=NONE      guifg=#ffffff
hi Identifier       gui=NONE      guibg=NONE      guifg=#ccccbb
hi Ignore           gui=italic    guibg=NONE      guifg=#ffffff
hi IncSearch        gui=italic    guibg=#777755   guifg=#ffff77
hi Keyword          gui=NONE      guibg=NONE      guifg=#dd9977
hi lCursor          gui=NONE      guibg=#ccccbb   guifg=#4466bb
hi LineNr           gui=italic    guibg=NONE      guifg=#ffffff
hi LineNrAbove      gui=italic    guibg=NONE      guifg=#ffffff
hi LineNrBelow      gui=italic    guibg=NONE      guifg=#ffffff
hi Macro            gui=italic    guibg=NONE      guifg=#ffffff
hi MatchParen       gui=bold      guibg=NONE      guifg=#ffee00
hi ModeMsg          gui=italic    guibg=NONE      guifg=#ffffff
hi MoreMsg          gui=bold      guibg=NONE      guifg=#aa77ff
hi NonText          gui=italic    guibg=NONE      guifg=#7777ff
hi Normal           gui=NONE      guibg=#333333   guifg=#aaaaaa
hi Number           gui=NONE      guibg=NONE      guifg=#77aa88
hi Question         gui=italic    guibg=NONE      guifg=#ffffff
hi QuickFixLine     gui=italic    guibg=NONE      guifg=#ffffff
hi Pmenu            gui=italic    guibg=NONE      guifg=#00ff00
hi PmenuSel         gui=italic    guibg=NONE      guifg=#0000ff
hi PmenuSbar        gui=italic    guibg=NONE      guifg=#ff0000
hi PmenuThumb       gui=italic    guibg=NONE      guifg=#00ffff
hi PreProc          gui=italic    guibg=NONE      guifg=#ff00ff
hi Search           gui=NONE      guibg=#777755   guifg=#ffffff
hi SignColumn       gui=italic    guibg=NONE      guifg=#ffffff
hi Special          gui=NONE      guibg=NONE      guifg=#ddaa55
hi SpecialChar      gui=italic    guibg=NONE      guifg=#ffffff
hi SpecialKey       gui=italic    guibg=NONE      guifg=#ffffff
hi SpellBad         gui=italic    guibg=NONE      guifg=#ff0000
hi SpellCap         gui=italic    guibg=NONE      guifg=#00ff00
hi SpellRare        gui=italic    guibg=NONE      guifg=#0000ff
hi SpellLocal       gui=italic    guibg=NONE      guifg=#00ffff
hi Statement        gui=NONE      guibg=NONE      guifg=#77bbdd
hi StatusLine       gui=bold      guibg=#777777   guifg=#000000
hi StatusLineNC     gui=NONE      guibg=#555555   guifg=#000000
hi StatusLineTerm   gui=bold      guibg=#668877   guifg=#000000
hi StatusLineTermNC gui=NONE      guibg=#446644   guifg=#000000
hi String           gui=NONE      guibg=#444444   guifg=#bb9933
hi TabLine          gui=italic    guibg=NONE      guifg=#ffffff
hi TabLineFill      gui=italic    guibg=NONE      guifg=#ffffff
hi TabLineSel       gui=italic    guibg=NONE      guifg=#ffffff
hi Title            gui=italic    guibg=NONE      guifg=#ffffff
hi Todo             gui=bold      guibg=#333333   guifg=#cc8899
hi ToolbarLine      gui=italic    guibg=#777777   guifg=#ffffff
hi ToolbarButton    gui=italic    guibg=#ffffff   guifg=#000000
hi Type             gui=italic    guibg=NONE      guifg=#ffffff
hi Underlined       gui=underline guibg=NONE      guifg=NONE
hi VertSplit        gui=bold      guibg=#777777   guifg=#000000
hi Visual           gui=NONE      guibg=#445566   guifg=NONE
hi VisualNOS        gui=NONE      guibg=#667788   guifg=NONE
hi WarningMsg       gui=NONE      guibg=#553333   guifg=#ffbb33
hi WildMenu         gui=italic    guibg=NONE      guifg=#ffffff
