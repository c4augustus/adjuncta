" Vim syntax file
" Language:     Aboa
" Authors:      ...
"               modified by ... <...@...>
" URL:          https://gitlab.com/aboa/aboa-vim
"
" Contributors: ... <...@...> (... support, bug fixes)
"
" Maintainer:   ... <...@...>
" License:      Same as Vim
" Last Change:  %%RELEASE_DATE%%

if exists("b:current_syntax")
    finish
endif

let s:cpo_sav = &cpo
set cpo&vim

if has("folding") && exists("g:aboa_fold") && g:aboa_fold > 0
    setlocal foldmethod=syntax
endif

" -*- KEYWORDS -*-
" Generated from https://github.com/guns/vim-aboa-static/blob/%%RELEASE_TAG%%/clj/src/vim_aboa_static/generate.clj
" Clojure version 1.8.0
"""let s:aboa_syntax_keywords = {
"""    \   'aboaBoolean': ["f","t"]
"""    \ , 'aboaCond': ["case","aboa.core/case","aboa.core/cond","aboa.core/cond->","aboa.core/cond->>","aboa.core/condp","aboa.core/if-let","aboa.core/if-not","aboa.core/if-some","aboa.core/when","aboa.core/when-first","aboa.core/when-let","aboa.core/when-not","aboa.core/when-some","cond","cond->","cond->>","condp","if-let","if-not","if-some","when","when-first","when-let","when-not","when-some"]
"""    \ , 'aboaConstant': ["nil"]
"""    \ , 'aboaDefine': [":","aboa.core/definline","aboa.core/definterface","aboa.core/defmacro","aboa.core/defmethod","aboa.core/defmulti","aboa.core/defn","aboa.core/defn-","aboa.core/defonce","aboa.core/defprotocol","aboa.core/defrecord","aboa.core/defstruct","aboa.core/deftype","definline","definterface","defmacro","defmethod","defmulti","defn","defn-","defonce","defprotocol","defrecord","defstruct","deftype"]
"""    \ , 'aboaException': ["catch","finally","throw","try"]
"""    \ , 'aboaFunc': ["*","*'","+","+'","-","-'","->ArrayChunk","->Eduction","->Vec","->VecNode","->VecSeq","-cache-protocol-fn","-reset-methods","/","<","<=","=","==",">",">=","Throwable->map","accessor","aclone","add-classpath","add-watch","agent","agent-error","agent-errors","aget","alength","alias","all-ns","alter","alter-meta!","alter-var-root","ancestors","apply","array-map","aset","aset-boolean","aset-byte","aset-char","aset-double","aset-float","aset-int","aset-long","aset-short","assoc","assoc!","assoc-in","associative?","atom","await","await-for","await1","bases","bean","bigdec","bigint","biginteger","bit-and","bit-and-not","bit-clear","bit-flip","bit-not","bit-or","bit-set","bit-shift-left","bit-shift-right","bit-test","bit-xor","boolean","boolean-array","booleans","bound-fn*","bound?","butlast","byte","byte-array","bytes","cast","cat","char","char-array","char?","chars","chunk","chunk-append","chunk-buffer","chunk-cons","chunk-first","chunk-next","chunk-rest","chunked-seq?","class","class?","clear-agent-errors","aboa-version","aboa.core/*","aboa.core/*'","aboa.core/+","aboa.core/+'","aboa.core/-","aboa.core/-'","aboa.core/->ArrayChunk","aboa.core/->Eduction","aboa.core/->Vec","aboa.core/->VecNode","aboa.core/->VecSeq","aboa.core/-cache-protocol-fn","aboa.core/-reset-methods","aboa.core//","aboa.core/<","aboa.core/<=","aboa.core/=","aboa.core/==","aboa.core/>","aboa.core/>=","aboa.core/Throwable->map","aboa.core/accessor","aboa.core/aclone","aboa.core/add-classpath","aboa.core/add-watch","aboa.core/agent","aboa.core/agent-error","aboa.core/agent-errors","aboa.core/aget","aboa.core/alength","aboa.core/alias","aboa.core/all-ns","aboa.core/alter","aboa.core/alter-meta!","aboa.core/alter-var-root","aboa.core/ancestors","aboa.core/apply","aboa.core/array-map","aboa.core/aset","aboa.core/aset-boolean","aboa.core/aset-byte","aboa.core/aset-char","aboa.core/aset-double","aboa.core/aset-float","aboa.core/aset-int","aboa.core/aset-long","aboa.core/aset-short","aboa.core/assoc","aboa.core/assoc!","aboa.core/assoc-in","aboa.core/associative?","aboa.core/atom","aboa.core/await","aboa.core/await-for","aboa.core/await1","aboa.core/bases","aboa.core/bean","aboa.core/bigdec","aboa.core/bigint","aboa.core/biginteger","aboa.core/bit-and","aboa.core/bit-and-not","aboa.core/bit-clear","aboa.core/bit-flip","aboa.core/bit-not","aboa.core/bit-or","aboa.core/bit-set","aboa.core/bit-shift-left","aboa.core/bit-shift-right","aboa.core/bit-test","aboa.core/bit-xor","aboa.core/boolean","aboa.core/boolean-array","aboa.core/booleans","aboa.core/bound-fn*","aboa.core/bound?","aboa.core/butlast","aboa.core/byte","aboa.core/byte-array","aboa.core/bytes","aboa.core/cast","aboa.core/cat","aboa.core/char","aboa.core/char-array","aboa.core/char?","aboa.core/chars","aboa.core/chunk","aboa.core/chunk-append","aboa.core/chunk-buffer","aboa.core/chunk-cons","aboa.core/chunk-first","aboa.core/chunk-next","aboa.core/chunk-rest","aboa.core/chunked-seq?","aboa.core/class","aboa.core/class?","aboa.core/clear-agent-errors","aboa.core/aboa-version","aboa.core/coll?","aboa.core/commute","aboa.core/comp","aboa.core/comparator","aboa.core/compare","aboa.core/compare-and-set!","aboa.core/compile","aboa.core/complement","aboa.core/completing","aboa.core/concat","aboa.core/conj","aboa.core/conj!","aboa.core/cons","aboa.core/constantly","aboa.core/construct-proxy","aboa.core/contains?","aboa.core/count","aboa.core/counted?","aboa.core/create-ns","aboa.core/create-struct","aboa.core/cycle","aboa.core/dec","aboa.core/dec'","aboa.core/decimal?","aboa.core/dedupe","aboa.core/delay?","aboa.core/deliver","aboa.core/denominator","aboa.core/deref","aboa.core/derive","aboa.core/descendants","aboa.core/destructure","aboa.core/disj","aboa.core/disj!","aboa.core/dissoc","aboa.core/dissoc!","aboa.core/distinct","aboa.core/distinct?","aboa.core/doall","aboa.core/dorun","aboa.core/double","aboa.core/double-array","aboa.core/doubles","aboa.core/drop","aboa.core/drop-last","aboa.core/drop-while","aboa.core/eduction","aboa.core/empty","aboa.core/empty?","aboa.core/ensure","aboa.core/ensure-reduced","aboa.core/enumeration-seq","aboa.core/error-handler","aboa.core/error-mode","aboa.core/eval","aboa.core/even?","aboa.core/every-pred","aboa.core/every?","aboa.core/ex-data","aboa.core/ex-info","aboa.core/extend","aboa.core/extenders","aboa.core/extends?","aboa.core/false?","aboa.core/ffirst","aboa.core/file-seq","aboa.core/filter","aboa.core/filterv","aboa.core/find","aboa.core/find-keyword","aboa.core/find-ns","aboa.core/find-protocol-impl","aboa.core/find-protocol-method","aboa.core/find-var","aboa.core/first","aboa.core/flatten","aboa.core/float","aboa.core/float-array","aboa.core/float?","aboa.core/floats","aboa.core/flush","aboa.core/fn?","aboa.core/fnext","aboa.core/fnil","aboa.core/force","aboa.core/format","aboa.core/frequencies","aboa.core/future-call","aboa.core/future-cancel","aboa.core/future-cancelled?","aboa.core/future-done?","aboa.core/future?","aboa.core/gensym","aboa.core/get","aboa.core/get-in","aboa.core/get-method","aboa.core/get-proxy-class","aboa.core/get-thread-bindings","aboa.core/get-validator","aboa.core/group-by","aboa.core/hash","aboa.core/hash-combine","aboa.core/hash-map","aboa.core/hash-ordered-coll","aboa.core/hash-set","aboa.core/hash-unordered-coll","aboa.core/identical?","aboa.core/identity","aboa.core/ifn?","aboa.core/in-ns","aboa.core/inc","aboa.core/inc'","aboa.core/init-proxy","aboa.core/instance?","aboa.core/int","aboa.core/int-array","aboa.core/integer?","aboa.core/interleave","aboa.core/intern","aboa.core/interpose","aboa.core/into","aboa.core/into-array","aboa.core/ints","aboa.core/isa?","aboa.core/iterate","aboa.core/iterator-seq","aboa.core/juxt","aboa.core/keep","aboa.core/keep-indexed","aboa.core/key","aboa.core/keys","aboa.core/keyword","aboa.core/keyword?","aboa.core/last","aboa.core/line-seq","aboa.core/list","aboa.core/list*","aboa.core/list?","aboa.core/load","aboa.core/load-file","aboa.core/load-reader","aboa.core/load-string","aboa.core/loaded-libs","aboa.core/long","aboa.core/long-array","aboa.core/longs","aboa.core/macroexpand","aboa.core/macroexpand-1","aboa.core/make-array","aboa.core/make-hierarchy","aboa.core/map","aboa.core/map-entry?","aboa.core/map-indexed","aboa.core/map?","aboa.core/mapcat","aboa.core/mapv","aboa.core/max","aboa.core/max-key","aboa.core/memoize","aboa.core/merge","aboa.core/merge-with","aboa.core/meta","aboa.core/method-sig","aboa.core/methods","aboa.core/min","aboa.core/min-key","aboa.core/mix-collection-hash","aboa.core/mod","aboa.core/munge","aboa.core/name","aboa.core/namespace","aboa.core/namespace-munge","aboa.core/neg?","aboa.core/newline","aboa.core/next","aboa.core/nfirst","aboa.core/nil?","aboa.core/nnext","aboa.core/not","aboa.core/not-any?","aboa.core/not-empty","aboa.core/not-every?","aboa.core/not=","aboa.core/ns-aliases","aboa.core/ns-imports","aboa.core/ns-interns","aboa.core/ns-map","aboa.core/ns-name","aboa.core/ns-publics","aboa.core/ns-refers","aboa.core/ns-resolve","aboa.core/ns-unalias","aboa.core/ns-unmap","aboa.core/nth","aboa.core/nthnext","aboa.core/nthrest","aboa.core/num","aboa.core/number?","aboa.core/numerator","aboa.core/object-array","aboa.core/odd?","aboa.core/parents","aboa.core/partial","aboa.core/partition","aboa.core/partition-all","aboa.core/partition-by","aboa.core/pcalls","aboa.core/peek","aboa.core/persistent!","aboa.core/pmap","aboa.core/pop","aboa.core/pop!","aboa.core/pop-thread-bindings","aboa.core/pos?","aboa.core/pr","aboa.core/pr-str","aboa.core/prefer-method","aboa.core/prefers","aboa.core/print","aboa.core/print-ctor","aboa.core/print-dup","aboa.core/print-method","aboa.core/print-simple","aboa.core/print-str","aboa.core/printf","aboa.core/println","aboa.core/println-str","aboa.core/prn","aboa.core/prn-str","aboa.core/promise","aboa.core/proxy-call-with-super","aboa.core/proxy-mappings","aboa.core/proxy-name","aboa.core/push-thread-bindings","aboa.core/quot","aboa.core/rand","aboa.core/rand-int","aboa.core/rand-nth","aboa.core/random-sample","aboa.core/range","aboa.core/ratio?","aboa.core/rational?","aboa.core/rationalize","aboa.core/re-find","aboa.core/re-groups","aboa.core/re-matcher","aboa.core/re-matches","aboa.core/re-pattern","aboa.core/re-seq","aboa.core/read","aboa.core/read-line","aboa.core/read-string","aboa.core/reader-conditional","aboa.core/reader-conditional?","aboa.core/realized?","aboa.core/record?","aboa.core/reduce","aboa.core/reduce-kv","aboa.core/reduced","aboa.core/reduced?","aboa.core/reductions","aboa.core/ref","aboa.core/ref-history-count","aboa.core/ref-max-history","aboa.core/ref-min-history","aboa.core/ref-set","aboa.core/refer","aboa.core/release-pending-sends","aboa.core/rem","aboa.core/remove","aboa.core/remove-all-methods","aboa.core/remove-method","aboa.core/remove-ns","aboa.core/remove-watch","aboa.core/repeat","aboa.core/repeatedly","aboa.core/replace","aboa.core/replicate","aboa.core/require","aboa.core/reset!","aboa.core/reset-meta!","aboa.core/resolve","aboa.core/rest","aboa.core/restart-agent","aboa.core/resultset-seq","aboa.core/reverse","aboa.core/reversible?","aboa.core/rseq","aboa.core/rsubseq","aboa.core/run!","aboa.core/satisfies?","aboa.core/second","aboa.core/select-keys","aboa.core/send","aboa.core/send-off","aboa.core/send-via","aboa.core/seq","aboa.core/seq?","aboa.core/seque","aboa.core/sequence","aboa.core/sequential?","aboa.core/set","aboa.core/set-agent-send-executor!","aboa.core/set-agent-send-off-executor!","aboa.core/set-error-handler!","aboa.core/set-error-mode!","aboa.core/set-validator!","aboa.core/set?","aboa.core/short","aboa.core/short-array","aboa.core/shorts","aboa.core/shuffle","aboa.core/shutdown-agents","aboa.core/slurp","aboa.core/some","aboa.core/some-fn","aboa.core/some?","aboa.core/sort","aboa.core/sort-by","aboa.core/sorted-map","aboa.core/sorted-map-by","aboa.core/sorted-set","aboa.core/sorted-set-by","aboa.core/sorted?","aboa.core/special-symbol?","aboa.core/spit","aboa.core/split-at","aboa.core/split-with","aboa.core/str","aboa.core/string?","aboa.core/struct","aboa.core/struct-map","aboa.core/subs","aboa.core/subseq","aboa.core/subvec","aboa.core/supers","aboa.core/swap!","aboa.core/symbol","aboa.core/symbol?","aboa.core/tagged-literal","aboa.core/tagged-literal?","aboa.core/take","aboa.core/take-last","aboa.core/take-nth","aboa.core/take-while","aboa.core/test","aboa.core/the-ns","aboa.core/thread-bound?","aboa.core/to-array","aboa.core/to-array-2d","aboa.core/trampoline","aboa.core/transduce","aboa.core/transient","aboa.core/tree-seq","aboa.core/true?","aboa.core/type","aboa.core/unchecked-add","aboa.core/unchecked-add-int","aboa.core/unchecked-byte","aboa.core/unchecked-char","aboa.core/unchecked-dec","aboa.core/unchecked-dec-int","aboa.core/unchecked-divide-int","aboa.core/unchecked-double","aboa.core/unchecked-float","aboa.core/unchecked-inc","aboa.core/unchecked-inc-int","aboa.core/unchecked-int","aboa.core/unchecked-long","aboa.core/unchecked-multiply","aboa.core/unchecked-multiply-int","aboa.core/unchecked-negate","aboa.core/unchecked-negate-int","aboa.core/unchecked-remainder-int","aboa.core/unchecked-short","aboa.core/unchecked-subtract","aboa.core/unchecked-subtract-int","aboa.core/underive","aboa.core/unreduced","aboa.core/unsigned-bit-shift-right","aboa.core/update","aboa.core/update-in","aboa.core/update-proxy","aboa.core/use","aboa.core/val","aboa.core/vals","aboa.core/var-get","aboa.core/var-set","aboa.core/var?","aboa.core/vary-meta","aboa.core/vec","aboa.core/vector","aboa.core/vector-of","aboa.core/vector?","aboa.core/volatile!","aboa.core/volatile?","aboa.core/vreset!","aboa.core/with-bindings*","aboa.core/with-meta","aboa.core/with-redefs-fn","aboa.core/xml-seq","aboa.core/zero?","aboa.core/zipmap","coll?","commute","comp","comparator","compare","compare-and-set!","compile","complement","completing","concat","conj","conj!","cons","constantly","construct-proxy","contains?","count","counted?","create-ns","create-struct","cycle","dec","dec'","decimal?","dedupe","delay?","deliver","denominator","deref","derive","descendants","destructure","disj","disj!","dissoc","dissoc!","distinct","distinct?","doall","dorun","double","double-array","doubles","drop","drop-last","drop-while","eduction","empty","empty?","ensure","ensure-reduced","enumeration-seq","error-handler","error-mode","eval","even?","every-pred","every?","ex-data","ex-info","extend","extenders","extends?","false?","ffirst","file-seq","filter","filterv","find","find-keyword","find-ns","find-protocol-impl","find-protocol-method","find-var","first","flatten","float","float-array","float?","floats","flush","fn?","fnext","fnil","force","format","frequencies","future-call","future-cancel","future-cancelled?","future-done?","future?","gensym","get","get-in","get-method","get-proxy-class","get-thread-bindings","get-validator","group-by","hash","hash-combine","hash-map","hash-ordered-coll","hash-set","hash-unordered-coll","identical?","identity","ifn?","in-ns","inc","inc'","init-proxy","instance?","int","int-array","integer?","interleave","intern","interpose","into","into-array","ints","isa?","iterate","iterator-seq","juxt","keep","keep-indexed","key","keys","keyword","keyword?","last","line-seq","list","list*","list?","load","load-file","load-reader","load-string","loaded-libs","long","long-array","longs","macroexpand","macroexpand-1","make-array","make-hierarchy","map","map-entry?","map-indexed","map?","mapcat","mapv","max","max-key","memoize","merge","merge-with","meta","method-sig","methods","min","min-key","mix-collection-hash","mod","munge","name","namespace","namespace-munge","neg?","newline","next","nfirst","nil?","nnext","not","not-any?","not-empty","not-every?","not=","ns-aliases","ns-imports","ns-interns","ns-map","ns-name","ns-publics","ns-refers","ns-resolve","ns-unalias","ns-unmap","nth","nthnext","nthrest","num","number?","numerator","object-array","odd?","parents","partial","partition","partition-all","partition-by","pcalls","peek","persistent!","pmap","pop","pop!","pop-thread-bindings","pos?","pr","pr-str","prefer-method","prefers","print","print-ctor","print-dup","print-method","print-simple","print-str","printf","println","println-str","prn","prn-str","promise","proxy-call-with-super","proxy-mappings","proxy-name","push-thread-bindings","quot","rand","rand-int","rand-nth","random-sample","range","ratio?","rational?","rationalize","re-find","re-groups","re-matcher","re-matches","re-pattern","re-seq","read","read-line","read-string","reader-conditional","reader-conditional?","realized?","record?","reduce","reduce-kv","reduced","reduced?","reductions","ref","ref-history-count","ref-max-history","ref-min-history","ref-set","refer","release-pending-sends","rem","remove","remove-all-methods","remove-method","remove-ns","remove-watch","repeat","repeatedly","replace","replicate","require","reset!","reset-meta!","resolve","rest","restart-agent","resultset-seq","reverse","reversible?","rseq","rsubseq","run!","satisfies?","second","select-keys","send","send-off","send-via","seq","seq?","seque","sequence","sequential?","set","set-agent-send-executor!","set-agent-send-off-executor!","set-error-handler!","set-error-mode!","set-validator!","set?","short","short-array","shorts","shuffle","shutdown-agents","slurp","some","some-fn","some?","sort","sort-by","sorted-map","sorted-map-by","sorted-set","sorted-set-by","sorted?","special-symbol?","spit","split-at","split-with","str","string?","struct","struct-map","subs","subseq","subvec","supers","swap!","symbol","symbol?","tagged-literal","tagged-literal?","take","take-last","take-nth","take-while","test","the-ns","thread-bound?","to-array","to-array-2d","trampoline","transduce","transient","tree-seq","true?","type","unchecked-add","unchecked-add-int","unchecked-byte","unchecked-char","unchecked-dec","unchecked-dec-int","unchecked-divide-int","unchecked-double","unchecked-float","unchecked-inc","unchecked-inc-int","unchecked-int","unchecked-long","unchecked-multiply","unchecked-multiply-int","unchecked-negate","unchecked-negate-int","unchecked-remainder-int","unchecked-short","unchecked-subtract","unchecked-subtract-int","underive","unreduced","unsigned-bit-shift-right","update","update-in","update-proxy","use","val","vals","var-get","var-set","var?","vary-meta","vec","vector","vector-of","vector?","volatile!","volatile?","vreset!","with-bindings*","with-meta","with-redefs-fn","xml-seq","zero?","zipmap"]
"""    \ , 'aboaMacro': ["->","->>","..","amap","and","areduce","as->","assert","binding","bound-fn","aboa.core/->","aboa.core/->>","aboa.core/..","aboa.core/amap","aboa.core/and","aboa.core/areduce","aboa.core/as->","aboa.core/assert","aboa.core/binding","aboa.core/bound-fn","aboa.core/comment","aboa.core/declare","aboa.core/delay","aboa.core/dosync","aboa.core/doto","aboa.core/extend-protocol","aboa.core/extend-type","aboa.core/for","aboa.core/future","aboa.core/gen-class","aboa.core/gen-interface","aboa.core/import","aboa.core/io!","aboa.core/lazy-cat","aboa.core/lazy-seq","aboa.core/letfn","aboa.core/locking","aboa.core/memfn","aboa.core/ns","aboa.core/or","aboa.core/proxy","aboa.core/proxy-super","aboa.core/pvalues","aboa.core/refer-aboa","aboa.core/reify","aboa.core/some->","aboa.core/some->>","aboa.core/sync","aboa.core/time","aboa.core/vswap!","aboa.core/with-bindings","aboa.core/with-in-str","aboa.core/with-loading-context","aboa.core/with-local-vars","aboa.core/with-open","aboa.core/with-out-str","aboa.core/with-precision","aboa.core/with-redefs","comment","declare","delay","dosync","doto","extend-protocol","extend-type","for","future","gen-class","gen-interface","import","io!","lazy-cat","lazy-seq","letfn","locking","memfn","ns","or","proxy","proxy-super","pvalues","refer-aboa","reify","some->","some->>","sync","time","vswap!","with-bindings","with-in-str","with-loading-context","with-local-vars","with-open","with-out-str","with-precision","with-redefs"]
"""    \ , 'aboaRepeat': ["aboa.core/doseq","aboa.core/dotimes","aboa.core/while","doseq","dotimes","while"]
"""    \ , 'aboaSpecial': [".","aboa.core/fn","aboa.core/let","aboa.core/loop","def","do","fn","if","let","loop","monitor-enter","monitor-exit","new","quote","recur","set!","var"]
"""    \ , 'aboaVariable': ["*1","*2","*3","*agent*","*allow-unresolved-vars*","*assert*","*aboa-version*","*command-line-args*","*compile-files*","*compile-path*","*compiler-options*","*data-readers*","*default-data-reader-fn*","*e","*err*","*file*","*flush-on-newline*","*fn-loader*","*in*","*math-context*","*ns*","*out*","*print-dup*","*print-length*","*print-level*","*print-meta*","*print-readably*","*read-eval*","*source-path*","*suppress-read*","*unchecked-math*","*use-context-classloader*","*verbose-defrecords*","*warn-on-reflection*","EMPTY-NODE","char-escape-string","char-name-string","aboa.core/*1","aboa.core/*2","aboa.core/*3","aboa.core/*agent*","aboa.core/*allow-unresolved-vars*","aboa.core/*assert*","aboa.core/*aboa-version*","aboa.core/*command-line-args*","aboa.core/*compile-files*","aboa.core/*compile-path*","aboa.core/*compiler-options*","aboa.core/*data-readers*","aboa.core/*default-data-reader-fn*","aboa.core/*e","aboa.core/*err*","aboa.core/*file*","aboa.core/*flush-on-newline*","aboa.core/*fn-loader*","aboa.core/*in*","aboa.core/*math-context*","aboa.core/*ns*","aboa.core/*out*","aboa.core/*print-dup*","aboa.core/*print-length*","aboa.core/*print-level*","aboa.core/*print-meta*","aboa.core/*print-readably*","aboa.core/*read-eval*","aboa.core/*source-path*","aboa.core/*suppress-read*","aboa.core/*unchecked-math*","aboa.core/*use-context-classloader*","aboa.core/*verbose-defrecords*","aboa.core/*warn-on-reflection*","aboa.core/EMPTY-NODE","aboa.core/char-escape-string","aboa.core/char-name-string","aboa.core/default-data-readers","aboa.core/primitives-classnames","aboa.core/unquote","aboa.core/unquote-splicing","default-data-readers","primitives-classnames","unquote","unquote-splicing"]
"""    \ }
let s:aboa_syntax_keywords = {
    \   'aboaBuiltin':  ["format"]
    \ , 'aboaOperator': ["*","*'","+","+'","-","-'","/","<","<=","=","==",">",">="]
    \ }

function! s:syntax_keyword(dict)
    for key in keys(a:dict)
        execute 'syntax keyword' key join(a:dict[key], ' ')
    endfor
endfunction

"""if exists('b:aboa_syntax_without_core_keywords') && b:aboa_syntax_without_core_keywords
"""    " Only match language specials and primitives
"""    for s:key in ['aboaBoolean', 'aboaConstant', 'aboaException', 'aboaSpecial']
"""        execute 'syntax keyword' s:key join(s:aboa_syntax_keywords[s:key], ' ')
"""    endfor
"""else
"""    call s:syntax_keyword(s:aboa_syntax_keywords)
"""endif

if exists('g:aboa_syntax_keywords')
    call s:syntax_keyword(g:aboa_syntax_keywords)
endif

if exists('b:aboa_syntax_keywords')
    call s:syntax_keyword(b:aboa_syntax_keywords)
endif

unlet! s:key
delfunction s:syntax_keyword

syntax match aboaConstant "\$[-a-zA-Z0-9_]*"
syntax match aboaBooleanFalse "\$f[-_a-zA-Z0-9_]\@!"
syntax match aboaBooleanTrue "\$t[-_a-zA-Z0-9_]\@!"

" Keywords are symbols:
"   static Pattern symbolPat = Pattern.compile("[:]?([\\D&&[^/]].*/)?([\\D&&[^/]][^/]*)");
" But they:
"   * Must not end in a : or /
"   * Must not have two adjacent colons except at the beginning
"   * Must not contain any reader metacharacters except for ' and #
"""syntax match aboaKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\%/]+/)*[^ \n\r\t()\[\]{}";@^`~\\%/]+:@<!>"
syntax match aboaSymbol "[\.\!\:\%\&\?\^\~]"

syntax match aboaStringEscape "\v\\%([\\btnfr"]|u\x{4}|[0-3]\o{2}|\o{1,2})" contained

syntax region aboaString matchgroup=aboaStringDelimiter start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=aboaStringEscape,@Spell

syntax match aboaCharacter "\\."
syntax match aboaCharacter "\\o\%([0-3]\o\{2\}\|\o\{1,2\}\)"
syntax match aboaCharacter "\\u\x\{4\}"
syntax match aboaCharacter "\\space"
syntax match aboaCharacter "\\tab"
syntax match aboaCharacter "\\newline"
syntax match aboaCharacter "\\return"
syntax match aboaCharacter "\\backspace"
syntax match aboaCharacter "\\formfeed"

"""syntax match aboaSymbol "\v%([a-zA-Z!$&*_+=|<.>?-]|[^\x00-\x7F])+%(:?%([a-zA-Z0-9!#$%&*_+=|'<.>/?-]|[^\x00-\x7F]))*[#:]@<!"

let s:radix_chars = "0123456789abcdefghijklmnopqrstuvwxyz"
for s:radix in range(2, 36)
    execute 'syntax match aboaNumber "\v\c<[-+]?' . s:radix . 'r[' . strpart(s:radix_chars, 0, s:radix) . ']+>"'
endfor
unlet! s:radix_chars s:radix

syntax match aboaNumber "\v<[-+]?%(0\o*|0x\x+|[1-9]\d*)N?>"
syntax match aboaNumber "\v<[-+]?%(0|[1-9]\d*|%(0|[1-9]\d*)\.\d*)%(M|[eE][-+]?\d+)?>"
syntax match aboaNumber "\v<[-+]?%(0|[1-9]\d*)/%(0|[1-9]\d*)>"

"""syntax match aboaVarArg "&"

syntax match aboaQuote "'"
syntax match aboaQuote "`"
"""syntax match aboaUnquote "\~"
"""syntax match aboaUnquote "\~@"
"""syntax match aboaMeta "\^"
syntax match aboaDeref "@"
syntax match aboaDispatch "\v#[\^'=<_]?"

" Clojure permits no more than 20 anonymous params.
"""syntax match aboaAnonArg "%\(20\|1\d\|[1-9]\|&\)\?"

"""syntax match  aboaRegexpEscape "\v\\%([\\tnrfae.()\[\]{}^$*?+]|c\u|0[0-3]?\o{1,2}|x%(\x{2}|\{\x{1,6}\})|u\x{4})" contained display
"""syntax region aboaRegexpQuoted start=/\\Q/ms=e+1 skip=/\\\\\|\\"/ end=/\\E/me=s-1 end=/"/me=s-1 contained
"""syntax region aboaRegexpQuote  start=/\\Q/       skip=/\\\\\|\\"/ end=/\\E/       end=/"/me=s-1 contains=aboaRegexpQuoted keepend contained

" -*- CHARACTER PROPERTY CLASSES -*-
" Generated from https://github.com/guns/vim-aboa-static/blob/%%RELEASE_TAG%%/clj/src/vim_aboa_static/generate.clj
" Java version 1.8.0_92
"""syntax match aboaRegexpPosixCharClass "\v\\[pP]\{%(Cntrl|A%(l%(pha|num)|SCII)|Space|Graph|Upper|P%(rint|unct)|Blank|XDigit|Digit|Lower)\}" contained display
"""syntax match aboaRegexpJavaCharClass "\v\\[pP]\{java%(Whitespace|JavaIdentifier%(Part|Start)|SpaceChar|Mirrored|TitleCase|I%(SOControl|de%(ographic|ntifierIgnorable))|D%(efined|igit)|U%(pperCase|nicodeIdentifier%(Part|Start))|L%(etter%(OrDigit)?|owerCase)|Alphabetic)\}" contained display
"""syntax match aboaRegexpUnicodeCharClass "\v\\[pP]\{\cIs%(l%(owercase|etter)|hex%(digit|_digit)|w%(hite%(_space|space)|ord)|noncharacter%(_code_point|codepoint)|p%(rint|unctuation)|ideographic|graph|a%(l%(num|phabetic)|ssigned)|uppercase|join%(control|_control)|titlecase|blank|digit|control)\}" contained display
"""syntax match aboaRegexpUnicodeCharClass "\v\\[pP][NSCMZPL]" contained display
"""syntax match aboaRegexpUnicodeCharClass "\v\\[pP]\{%(N[dlo]?|P[dcifeos]?|C[ncfos]?|M[nce]?|Z[lsp]?|S[mcko]?|L[muCDlto]?)\}" contained display
"""syntax match aboaRegexpUnicodeCharClass "\v\\[pP]\{%(Is|gc\=|general_category\=)?%(N[dlo]?|P[dcifeos]?|C[ncfos]?|M[nce]?|Z[lsp]?|S[mcko]?|L[muCDlto]?)\}" contained display
"""syntax match aboaRegexpUnicodeCharClass "\v\\[pP]\{\c%(Is|sc\=|script\=)%(l%(epc%(ha)?|y%([dc]i%(an)?)|a%(t%(n|in)|na|oo?)|i%(n%(b|ear_b)|mbu?|su))|p%(rti|lrd|h%(oenician|li|ag%(s_pa)?|nx))|vaii?|d%(srt|e%(seret|va%(nagari)?))|g%(lag%(olitic)?|eor%(gian)?|oth%(ic)?|re%(k|ek)|u%(j%(arati|r)|r%(u|mukhi)))|u%(gar%(itic)?|nknown)|a%(r%(ab%(ic)?|m%([ni]|enian))|v%(st|estan))|e%(thi%(opic)?|gyp%(tian_hieroglyphs)?)|z%(inh|yyy|zzz)|r%(un%(ic|r)|ejang|jng)|s%(inh%(ala)?|h%(rd|a%(vian|rada|w))|a%(ur%(ashtra)?|m%(r|aritan)|rb)|y%(r%(c|iac)|lo%(ti_nagri)?)|und%(anese)?|ora%(_sompeng)?)|i%(n%(scriptional_pa%(rthian|hlavi)|herited)|mperial_aramaic|tal)|b%(eng%(ali)?|a%(t%(ak|k)|li%(nese)?|mum?)|ra%(i%(lle)?|h%(mi)?)|opo%(mofo)?|u%(gi%(nese)?|h%(d|id)))|o%(g%(am|ham)|r%(iya|kh|ya)|sma%(nya)?|l%(d_%(south_arabian|persian|italic|turkic)|ck|_chiki))|k%(h%(m%(r|er)|ar%(oshthi)?)|nda|a%(li|n%(a|nada)|takana|yah_li|ithi)|thi)|m%(a%(nd%(aic)?|layalam)|lym|y%(anmar|mr)|tei|e%(r%(c|o%(itic_%(hieroglyphs|cursive))?)|etei_mayek)|ong%(olian)?|iao)|yi%(ii)?|x%(peo|sux)|n%(ew_tai_lue|koo?)|h%(ira%(gana)?|an%([io]|unoo|g%(ul)?)?|ebr%(ew)?)|c%(y%(priot|r%(l|illic))|a%(km|n%(adian_aboriginal|s)|ri%(an)?)|prt|h%(er%(okee)?|a%(m|kma))|uneiform|o%(pt%(ic)?|mmon))|t%(elu%(gu)?|i%(finagh|b%(t|etan))|ha%(i|a%(na)?)|a%(i_%(le|tham|viet)|g%(alog|b%(anwa)?)|vt|kri?|l[ue]|m%(il|l))|fng|glg)|java%(nese)?)\}" contained display
"""syntax match aboaRegexpUnicodeCharClass "\v\\[pP]\{\c%(In|blk\=|block\=)%(javanese|h%(a%(lfwidth%( and fullwidth forms|andfullwidthforms|_and_fullwidth_forms)|n%(unoo|gul%(compatibilityjamo|syllables|jamo%(extended\-[ab])?|_%(syllables|jamo%(_extended_[ab])?|compatibility_jamo)| %(syllables|compatibility jamo|jamo%( extended\-[ab])?))))|i%(ragana|gh%( %(private use surrogates|surrogates)|_%(private_use_surrogates|surrogates)|surrogates|privateusesurrogates))|ebrew)|i%(pa%([ _]extensions|extensions)|deographic%( description characters|_description_characters|descriptioncharacters)|nscriptional%(%([ _]pa%(rthian|hlavi))|pa%(rthian|hlavi))|mperial%(aramaic|[_ ]aramaic))|l%(e%(tterlike%([_ ]symbols|symbols)|pcha)|ow%([_ ]surrogates|surrogates)|i%(mbu|near%(_b_%(ideograms|syllabary)|b%(ideograms|syllabary)| b %(ideograms|syllabary))|su)|a%(tin%(extended%(additional|\-[dacb])| extended%( additional|\-[dacb])|\-1%(supplement| supplement)|_%(extended_%([dcb]|a%(dditional)?)|1_supplement))|o)|y[cd]ian)|b%(u%(ginese|hid)|ra%(hmi|ille%(patterns|[_ ]patterns))|o%(x%([ _]drawing|drawing)|pomofo%([ _]extended|extended)?)|lock%([ _]elements|elements)|yzantine%( musical symbols|musicalsymbols|_musical_symbols)|engali|a%(linese|mum%(supplement|[ _]supplement)?|tak|sic%([ _]latin|latin)))|e%(gyptian%([ _]hieroglyphs|hieroglyphs)|moticons|nclosed%( %(cjk letters and months|ideographic supplement|alphanumeric%( supplement|s))|cjklettersandmonths|_%(ideographic_supplement|alphanumeric%(_supplement|s)|cjk_letters_and_months)|alphanumerics%(upplement)?|ideographicsupplement)|thiopic%(supplement|_%(supplement|extended%(_a)?)| %(supplement|extended%(\-a)?)|extended%(\-a)?)?)|k%(h%(aroshthi|mer%([_ ]symbols|symbols)?)|a%(takana%(_phonetic_extensions|phoneticextensions| phonetic extensions)?|n%(gxi%([_ ]radicals|radicals)|a%(supplement|[ _]supplement)|bun|nada)|ithi|yah%([ _]li|li)))|m%(i%(ao|scellaneous%(technical|symbols%(and%(pictographs|arrows))?|mathematicalsymbols\-[ab]| %(technical|mathematical symbols\-[ab]|symbols%( and %(pictographs|arrows))?)|_%(technical|symbols%(_and_%(pictographs|arrows))?|mathematical_symbols_[ab])))|usical%([_ ]symbols|symbols)|e%(etei%(mayek%(extensions)?|_mayek%(_extensions)?| mayek%( extensions)?)|roitic%(hieroglyphs|%([_ ]%(hieroglyphs|cursive))|cursive))|a%(ndaic|hjong%([ _]tiles|tiles)|layalam|thematical%(alphanumericsymbols| %(alphanumeric symbols|operators)|_%(alphanumeric_symbols|operators)|operators))|yanmar%(extended\-a|_extended_a| extended\-a)?|o%(difier%(_tone_letters| tone letters|toneletters)|ngolian))|r%(u%(nic|mi%(numeralsymbols| numeral symbols|_numeral_symbols))|ejang)|n%(umber%(forms|[ _]forms)|ko|ew%(_tai_lue|tailue| tai lue))|c%(o%(ntrol%(pictures|[ _]pictures)|m%(bining%(diacriticalmarks%(supplement|forsymbols)?|halfmarks| %(diacritical marks%( %(supplement|for symbols))?|half marks|marks for symbols)|marksforsymbols|_%(marks_for_symbols|half_marks|diacritical_marks%(_supplement)?))|mon%(_indic_number_forms|indicnumberforms| indic number forms))|ptic|unting%( rod numerals|_rod_numerals|rodnumerals))|y%(rillic%(extended\-[ab]|_%(extended_[ab]|supplementary)|supplement%(ary)?| %(extended\-[ab]|supplement%(ary)?))?|priot%(syllabary|[ _]syllabary))|u%(rrency%([_ ]symbols|symbols)|neiform%(_numbers_and_punctuation|numbersandpunctuation| numbers and punctuation)?)|h%(a%(m|kma)|erokee)|arian|jk%(s%(ymbolsandpunctuation|trokes)|compatibility%(forms|ideographs%(supplement)?)?|radicalssupplement| %(compatibility%( %(ideographs%( supplement)?|forms))?|radicals supplement|unified ideographs%( extension [dacb])?|s%(ymbols and punctuation|trokes))|_%(s%(trokes|ymbols_and_punctuation)|radicals_supplement|compatibility%(_%(forms|ideographs%(_supplement)?))?|unified_ideographs%(_extension_[dacb])?)|unifiedideographs%(extension[dacb])?))|d%(e%(seret|vanagari%([ _]extended|extended)?)|ingbats|omino%([ _]tiles|tiles))|yi%(syllables|%([_ ]%(syllables|radicals))|radicals|jing%(hexagramsymbols| hexagram symbols|_hexagram_symbols))|s%(mall%( form variants|formvariants|_form_variants)|p%(acing%(_modifier_letters| modifier letters|modifierletters)|ecials)|ora%(sompeng|[ _]sompeng)|ha%(vian|rada)|a%(maritan|urashtra)|inhala|y%(riac|loti%([_ ]nagri|nagri))|u%(ndanese%(supplement|[ _]supplement)?|p%(erscripts%(_and_subscripts|andsubscripts| and subscripts)|plementa%(ry%(_private_use_area_[ab]|privateusearea\-[ab]| private use area\-[ab])|l%(_%(arrows_[ab]|mathematical_operators|punctuation)| %(mathematical operators|punctuation|arrows\-[ab])|mathematicaloperators|punctuation|arrows\-[ab])))|rrogates_area))|p%(h%(o%(enician|netic%( extensions%( supplement)?|extensions%(supplement)?|_extensions%(_supplement)?))|a%(istos%([ _]disc|disc)|gs[_\-]pa))|laying%(cards|[_ ]cards)|rivate%(usearea| use area|_use_area))|o%(smanya|l%([ _]chiki|d%( %(south arabian|persian|italic|turkic)|southarabian|_%(south_arabian|persian|italic|turkic)|persian|italic|turkic)|chiki)|riya|ptical%( character recognition|_character_recognition|characterrecognition)|gham)|g%(u%(jarati|rmukhi)|othic|lagolitic|e%(o%(rgian%(supplement|[ _]supplement)?|metric%(shapes|[ _]shapes))|neral%([_ ]punctuation|punctuation))|reek%( %(and coptic|extended)|andcoptic|_extended|extended)?)|t%(i%(betan|finagh)|elugu|ransport%( and map symbols|_and_map_symbols|andmapsymbols)|a%(mil|kri|i%(xuanjingsymbols|_%(le|xuan_jing_symbols|tham|viet)|le| %(xuan jing symbols|le|tham|viet)|tham|viet)|g%(alog|s|banwa))|ha%(i|ana))|a%(l%(chemical%([_ ]symbols|symbols)|phabetic%( presentation forms|_presentation_forms|presentationforms))|r%(menian|abic%(extended\-a|mathematicalalphabeticsymbols|supplement|_%(presentation_forms_[ab]|supplement|extended_a|mathematical_alphabetic_symbols)| %(extended\-a|mathematical alphabetic symbols|supplement|presentation forms\-[ab])|presentationforms\-[ab])?|rows)|ncient%(_%(greek_%(musical_notation|numbers)|symbols)|greek%(numbers|musicalnotation)| %(greek %(numbers|musical notation)|symbols)|symbols)|egean%(numbers|[ _]numbers)|vestan)|u%(garitic|nified%(canadianaboriginalsyllabics%(extended)?|_canadian_aboriginal_syllabics%(_extended)?| canadian aboriginal syllabics%( extended)?))|v%(a%(i|riation%( selectors%( supplement)?|selectors%(supplement)?|_selectors%(_supplement)?))|e%(rtical%(forms|[ _]forms)|dic%([ _]extensions|extensions))))\}" contained display

"""syntax match   aboaRegexpPredefinedCharClass "\v%(\\[dDsSwW]|\.)" contained display
"""syntax cluster aboaRegexpCharPropertyClasses contains=aboaRegexpPosixCharClass,aboaRegexpJavaCharClass,aboaRegexpUnicodeCharClass
"""syntax cluster aboaRegexpCharClasses         contains=aboaRegexpPredefinedCharClass,aboaRegexpCharClass,@aboaRegexpCharPropertyClasses
"""syntax region  aboaRegexpCharClass           start="\[" skip=/\\\\\|\\]/ end="]" contained contains=aboaRegexpPredefinedCharClass,@aboaRegexpCharPropertyClasses
"""syntax match   aboaRegexpBoundary            "\\[bBAGZz]" contained display
"""syntax match   aboaRegexpBoundary            "[$^]" contained display
"""syntax match   aboaRegexpQuantifier          "[?*+][?+]\=" contained display
"""syntax match   aboaRegexpQuantifier          "\v\{\d+%(,|,\d+)?}\??" contained display
"""syntax match   aboaRegexpOr                  "|" contained display
"""syntax match   aboaRegexpBackRef             "\v\\%([1-9]\d*|k\<[a-zA-z]+\>)" contained display

" Mode modifiers, mode-modified spans, lookaround, regular and atomic
" grouping, and named-capturing.
"""syntax match aboaRegexpMod "\v\(@<=\?:" contained display
"""syntax match aboaRegexpMod "\v\(@<=\?[xdsmiuU]*-?[xdsmiuU]+:?" contained display
"""syntax match aboaRegexpMod "\v\(@<=\?%(\<?[=!]|\>)" contained display
"""syntax match aboaRegexpMod "\v\(@<=\?\<[a-zA-Z]+\>" contained display

"""syntax region aboaRegexpGroup start="(" skip=/\\\\\|\\)/ end=")" matchgroup=aboaRegexpGroup contained contains=aboaRegexpMod,aboaRegexpQuantifier,aboaRegexpBoundary,aboaRegexpEscape,@aboaRegexpCharClasses
"""syntax region aboaRegexp start=/\#"/ skip=/\\\\\|\\"/ end=/"/ contains=@aboaRegexpCharClasses,aboaRegexpEscape,aboaRegexpQuote,aboaRegexpBoundary,aboaRegexpQuantifier,aboaRegexpOr,aboaRegexpBackRef,aboaRegexpGroup keepend

syntax keyword aboaCommentTodo contained FIXME XXX TODO FIXME: XXX: TODO:

syntax match aboaComment "#.*$" contains=aboaCommentTodo,@Spell
syntax match aboaComment "#!.*$"

" -*- TOP CLUSTER -*-
" Generated from https://github.com/guns/vim-aboa-static/blob/%%RELEASE_TAG%%/clj/src/vim_aboa_static/generate.clj
"""syntax cluster aboaTop contains=@Spell,aboaAnonArg,aboaBoolean,aboaCharacter,aboaComment,aboaCond,aboaConstant,aboaDefine,aboaDeref,aboaDispatch,aboaError,aboaException,aboaFunc,aboaKeyword,aboaMacro,aboaMap,aboaMeta,aboaNumber,aboaQuote,aboaRegexp,aboaRepeat,aboaSexp,aboaSpecial,aboaString,aboaSymbol,aboaUnquote,aboaVarArg,aboaVariable,aboaVector
syntax cluster aboaTop contains=@Spell,aboaBooleanFalse,aboaBooleanTrue,aboaBuiltin,aboaCharacter,aboaComment,aboaCond,aboaConstant,aboaDefine,aboaDeref,aboaDispatch,aboaError,aboaException,aboaKeyword,aboaMacro,aboaMap,aboaNumber,aboaOperator,aboaQuote,aboaRepeat,aboaSexp,aboaSpecial,aboaString,aboaSymbol,aboaVariable,aboaVector

syntax region aboaSexp   matchgroup=aboaParen start="("  end=")" contains=@aboaTop fold
syntax region aboaVector matchgroup=aboaParen start="\[" end="]" contains=@aboaTop fold
syntax region aboaMap    matchgroup=aboaParen start="{"  end="}" contains=@aboaTop fold

" Highlight superfluous closing parens, brackets and braces.
syntax match aboaError "]\|}\|)"

syntax sync fromstart

highlight default link aboaBoolean          Boolean
highlight default link aboaBooleanFalse     BooleanFalse
highlight default link aboaBooleanTrue      BooleanTrue
highlight default link aboaComment          Comment
highlight default link aboaCommentTodo      Todo
highlight default link aboaCond             Conditional
highlight default link aboaConstant         Constant
highlight default link aboaCharacter        Character
highlight default link aboaDefine           Define
highlight default link aboaDeref            SpecialChar
highlight default link aboaDispatch         SpecialChar
highlight default link aboaError            Error
highlight default link aboaException        Exception
highlight default link aboaFunc             Function
highlight default link aboaKeyword          Keyword
highlight default link aboaMacro            Macro
highlight default link aboaNumber           Number
highlight default link aboaParen            Delimiter
highlight default link aboaQuote            Constant
highlight default link aboaRepeat           Repeat
highlight default link aboaSpecial          Special
highlight default link aboaString           String
highlight default link aboaStringDelimiter  String
highlight default link aboaStringEscape     Character
highlight default link aboaSymbol           Special
highlight default link aboaVariable         Identifier

"""highlight default link aboaAnonArg                   SpecialChar
"""highlight default link aboaMeta                      SpecialChar
"""highlight default link aboaRegexp                    Constant
"""highlight default link aboaRegexpEscape              Character
"""highlight default link aboaRegexpCharClass           SpecialChar
"""highlight default link aboaRegexpPosixCharClass      aboaRegexpCharClass
"""highlight default link aboaRegexpJavaCharClass       aboaRegexpCharClass
"""highlight default link aboaRegexpUnicodeCharClass    aboaRegexpCharClass
"""highlight default link aboaRegexpPredefinedCharClass aboaRegexpCharClass
"""highlight default link aboaRegexpBoundary            SpecialChar
"""highlight default link aboaRegexpQuantifier          SpecialChar
"""highlight default link aboaRegexpMod                 SpecialChar
"""highlight default link aboaRegexpOr                  SpecialChar
"""highlight default link aboaRegexpBackRef             SpecialChar
"""highlight default link aboaRegexpGroup               aboaRegexp
"""highlight default link aboaRegexpQuote               aboaRegexpBoundary
"""highlight default link aboaRegexpQuoted              aboaString
"""highlight default link aboaUnquote                   SpecialChar
"""highlight default link aboaVarArg                    Special

let b:current_syntax = "aboa"

let &cpo = s:cpo_sav
unlet! s:cpo_sav

" vim:sts=8:sw=8:ts=8:noet
