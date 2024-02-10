if exists('b:current_syntax')
  finish
endif

syn match bqnerr "[^ \t\r\n]"
syn match bqnblk "[{}]"
syn match bqnlst "[⟨⟩\[\]‿]"
syn match bqnpar "[()]"
syn match bqnhed "[:;?]"
syn match bqnsep "[⋄,]"
syn match bqnarw "[←⇐↩→]"
syn match bqnchr "'.'"
syn match bqn1md "[˙˜˘¨⌜⁼´˝`]"
syn match bqn2md "[∘○⊸⟜⌾⊘◶⎉⚇⍟⎊]"
syn match bqnfun "[𝔽𝔾𝕎𝕏𝕊+\-×÷⋆√⌊⌈|¬∧∨<>≠=≤≥≡≢⊣⊢⥊∾≍⋈↑↓↕«»⌽⍉/⍋⍒⊏⊑⊐⊒∊⍷⊔!⍕⍎]"
syn match bqnsub "[𝕗𝕘𝕨𝕩𝕤]"
syn match bqnnot "·"
syn match bqnnul "@"
syn match bqnnum "\v\c%(¯_*)?%((\d[\d_]*(\.\d[\d_]*)?|π_*)%(e_*(¯_*)?\d[\d_]*)?|∞_*)(i_*%(¯_*)?%((\d[\d_]*(\.\d[\d_]*)?|π_*)%(e_*(¯_*)?\d[\d_]*)?|∞_*))?"
syn match bqnsid "\(•\|•\?[a-z][A-Z_a-z0-9π∞¯]*\|𝕣\)"
syn match bqnfid "•\?[A-Z][A-Z_a-z0-9π∞¯]*"
syn match bqn1id "\(•\?_[A-Za-z][A-Z_a-z0-9π∞¯]*\|_𝕣\)"
syn match bqn2id "\(•\?_[A-Za-z][A-Z_a-z0-9π∞¯]*_\|_𝕣_\)"
syn match bqndot "\."
syn match bqncom "#.*$"
syn match bqnquo /""/ contained
syn region bqnstr matchgroup=bqnstr start=/"/ end=/"/ contains=bqnquo
syn sync fromstart

hi default link bqnerr error
hi default link bqncom comment
hi default link bqnblk special
hi default link bqnhed delimiter
hi default link bqnpar delimiter
hi default link bqnlst preproc
hi default link bqnsep preproc
hi default link bqnarw normal
hi default link bqnchr string
hi default link bqnnul string
hi default link bqnstr string
hi default link bqnquo specialchar
hi default link bqnnum number
hi default link bqnnot constant
hi default link bqndot normal
hi default link bqnsub normal
hi default link bqnsid normal
hi default link bqnfun type
hi default link bqnfid type
hi default link bqn1md macro
hi default link bqn1id macro
hi default link bqn2md operator
hi default link bqn2id operator

let b:current_syntax='bqn'
