" Copyright 2023 Christopher Augustus
"
" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.
"
" ViM syntax rules for the Aboa programming language
" [regras de syntaxe de ViM para a linguaguem de programação Aboa]

if exists("b:current_syntax")
  finish
endif

let s:cpo_orig = &cpo
set cpo&vim

syntax match aboaCharEscape "\v\\%([\\tnrs"]|u\x{4})" contained

syntax match aboaCharacter "\\alarm"
syntax match aboaCharacter "\\backspace"
syntax match aboaCharacter "\\delete"
syntax match aboaCharacter "\\escape"
syntax match aboaCharacter "\\newline"
syntax match aboaCharacter "\\null"
syntax match aboaCharacter "\\return"
syntax match aboaCharacter "\\space"
syntax match aboaCharacter "\\tab"
syntax match aboaCharacter "\\u\x\{4\}"
"
syntax match aboaIdentifier   "[a-zA-Z_][-.a-zA-Z0-9_]*"
syntax match aboaQuoted       "\'[-a-zA-Z0-9_]*"
syntax match aboaConstant     "\$[-a-zA-Z0-9_]*"
syntax match aboaBooleanFalse "\$f[-_a-zA-Z0-9_]\@!"
syntax match aboaBooleanTrue  "\$t[-_a-zA-Z0-9_]\@!"
"
syntax match aboaNumber "\v<[-+]?%(0\o*|0x\x+|[1-9]\d*)N?>"
syntax match aboaNumber "\v<[-+]?%(0|[1-9]\d*|%(0|[1-9]\d*)\.\d*)%(M|[eE][-+]?\d+)?>"
syntax match aboaNumber "\v<[-+]?%(0|[1-9]\d*)/%(0|[1-9]\d*)>"
"
syntax match aboaSymbol "[\<\>\@\:\%\&\?\^\~]"
"
syntax match aboaOperator "<<"
syntax match aboaOperator "<="
syntax match aboaOperator "=="
syntax match aboaOperator "=>"
syntax match aboaOperator ">>"
syntax match aboaOperator "+"
syntax match aboaOperator "+'"
syntax match aboaOperator "-"
syntax match aboaOperator "-'"
syntax match aboaOperator "*"
syntax match aboaOperator "*'"
syntax match aboaOperator "/"
syntax match aboaOperator "|"

syntax keyword aboaBuiltinS7 abs acos apply ash asin atan ceiling complex cos cosh denominator display eval even? exp expt floor format gcd imag-part lcm logand logbit? logior lognot logxor magnitude map max min modulo nan nan? negative? numerator odd? quotient positive? random rationalize real-part remainder round sin sinh sqrt tan tanh truncate zero?
  " ^ TODO: only some of s7 English words until replaced by Aboa digraphs

syntax keyword aboaTodo contained FIXME TODO

syntax match aboaComment "#.*$" contains=aboaTodo
syntax region aboaComment  matchgroup=aboaCommentBlock start="#(" end=")#" contains=aboaTodo
syntax match aboaError "!#"
  " ^ unpaired closed aboaCommentBlock

syntax cluster aboaCluster contains=aboaBooleanFalse,aboaBooleanTrue,aboaBuiltinS7,aboaCharacter,aboaComment,aboaConstant,aboaError,aboaIdentifier,aboaKeyword,aboaNumber,aboaOperator,aboaQuoted,aboaSexpress,aboaSquoted,aboaString,aboaSymbol

syntax region aboaSexpress matchgroup=aboaParen  start="("  end=")" contains=@aboaCluster fold
syntax region aboaSquoted  matchgroup=aboaQuoted start="'(" end=")" contains=@aboaCluster fold
syntax match aboaError ")"
  " ^ unpaired closed aboaParen

syntax region aboaString matchgroup=aboaStringDelimiter start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=aboaCharacter,aboaCharEscape

syntax sync fromstart

hi default link aboaBoolean             Boolean
hi default link aboaBooleanFalse        BooleanFalse
hi default link aboaBooleanTrue         BooleanTrue
hi default link aboaBuiltinS7           Keyword
hi default link aboaComment             Comment
hi default link aboaCommentBlock        Comment
hi default link aboaConstant            Constant
hi default link aboaCharacter           Character
hi default link aboaCharEscape          Character
hi default link aboaError               Error
hi default link aboaIdentifier          Identifier
hi default link aboaKeyword             Keyword
hi default link aboaNumber              Number
hi default link aboaOperator            Keyword
hi default link aboaParen               Delimiter
hi default link aboaQuoted              Special
hi default link aboaString              String
hi default link aboaStringDelimiter     String
hi default link aboaSymbol              Statement
hi default link aboaTodo                Todo

let b:current_syntax = "aboa"

let &cpo = s:cpo_orig
unlet! s:cpo_orig
