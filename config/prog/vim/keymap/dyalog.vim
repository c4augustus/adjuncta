scripte utf-8
let b:keymap_name=expand('<sfile>:t:r')

let a ='`1234567890-= ~!@#$%^&*()_+'
let a.='qwertyuiop[]  QWERTYUIOP{} '
let a.='asdfghjkl;''\ ASDFGHJKL:"| '
let a.='zxcvbnm,./    ZXCVBNM<>?   '

let b ='⋄¨¯<≤=≥>≠∨∧×÷ ⌺⌶⍫⍒⍋⌽⍉⊖⍟⍱⍲!⌹'
let b.='?⍵∊⍴~↑↓⍳○*←→  ?⍵⍷⍴⍨↑↓⍸⍥⍣⍞⍬ '
let b.='⍺⌈⌊∥∇∆∘''⎕⍎⍕⊢ ⍺⌈⌊⊚∇∆⍤⌸⌷≡≢⊣ '
let b.='⊂⊃∩∪⊥⊤|⍝⍀⌿    ⊆⊃∩∪⊥⊤|⍪⍙⍠   '

let p=exists('g:apl_prefix_key')?g:apl_prefix_key:'`'
exe 'lno<buffer> '.p.'<space> '.p
exe 'cno<buffer> '.p.'<space> '.p
let[A,B]=map([a,b],"split(v:val,'\\zs *')")
for i in range(len(A))|exe escape('lno<buffer>'.p.A[i].' '.B[i],'|')|endfor
for i in range(len(A))|exe escape('cno<buffer>'.p.A[i].' '.B[i],'|')|endfor
unl a b A B i p
