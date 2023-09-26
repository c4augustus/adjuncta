" Vim syntax file
" Language:     Clojure
" Authors:      Toralf Wittner <toralf.wittner@gmail.com>
"               modified by Meikel Brandmeyer <mb@kotka.de>
" URL:          http://kotka.de/projects/lfe/vimlfe.html
"
" Contributors: Joel Holdbrooks <cjholdbrooks@gmail.com> (Regexp support, bug fixes)
"
" Maintainer:   Sung Pae <self@sungpae.com>
" URL:          https://github.com/guns/vim-lfe-static
" License:      Same as Vim
" Last Change:  %%RELEASE_DATE%%

if exists("b:current_syntax")
	finish
endif

let s:cpo_sav = &cpo
set cpo&vim

if has("folding") && exists("g:lfe_fold") && g:lfe_fold > 0
	setlocal foldmethod=syntax
endif

" -*- KEYWORDS -*-
" Generated from https://github.com/guns/vim-lfe-static/blob/%%RELEASE_TAG%%/clj/src/vim_lfe_static/generate.clj
" Clojure version 1.8.0
let s:lfe_syntax_keywords = {
    \   'lfeBoolean': ["false","true"]
    \ , 'lfeCond': ["case","lfe.core/case","lfe.core/cond","lfe.core/cond->","lfe.core/cond->>","lfe.core/condp","lfe.core/if-let","lfe.core/if-not","lfe.core/if-some","lfe.core/when","lfe.core/when-first","lfe.core/when-let","lfe.core/when-not","lfe.core/when-some","cond","cond->","cond->>","condp","if-let","if-not","if-some","when","when-first","when-let","when-not","when-some"]
    \ , 'lfeConstant': ["nil"]
    \ , 'lfeDefine': ["lfe.core/definline","lfe.core/definterface","lfe.core/defmacro","lfe.core/defmethod","lfe.core/defmulti","lfe.core/defn","lfe.core/defn-","lfe.core/defonce","lfe.core/defprotocol","lfe.core/defrecord","lfe.core/defstruct","lfe.core/deftype","definline","definterface","defmacro","defmethod","defmulti","defn","defn-","defonce","defprotocol","defrecord","defstruct","deftype"]
    \ , 'lfeException': ["catch","finally","throw","try"]
    \ , 'lfeFunc': ["*","*'","+","+'","-","-'","->ArrayChunk","->Eduction","->Vec","->VecNode","->VecSeq","-cache-protocol-fn","-reset-methods","/","<","<=","=","==",">",">=","Throwable->map","accessor","aclone","add-classpath","add-watch","agent","agent-error","agent-errors","aget","alength","alias","all-ns","alter","alter-meta!","alter-var-root","ancestors","apply","array-map","aset","aset-boolean","aset-byte","aset-char","aset-double","aset-float","aset-int","aset-long","aset-short","assoc","assoc!","assoc-in","associative?","atom","await","await-for","await1","bases","bean","bigdec","bigint","biginteger","bit-and","bit-and-not","bit-clear","bit-flip","bit-not","bit-or","bit-set","bit-shift-left","bit-shift-right","bit-test","bit-xor","boolean","boolean-array","booleans","bound-fn*","bound?","butlast","byte","byte-array","bytes","cast","cat","char","char-array","char?","chars","chunk","chunk-append","chunk-buffer","chunk-cons","chunk-first","chunk-next","chunk-rest","chunked-seq?","class","class?","clear-agent-errors","lfe-version","lfe.core/*","lfe.core/*'","lfe.core/+","lfe.core/+'","lfe.core/-","lfe.core/-'","lfe.core/->ArrayChunk","lfe.core/->Eduction","lfe.core/->Vec","lfe.core/->VecNode","lfe.core/->VecSeq","lfe.core/-cache-protocol-fn","lfe.core/-reset-methods","lfe.core//","lfe.core/<","lfe.core/<=","lfe.core/=","lfe.core/==","lfe.core/>","lfe.core/>=","lfe.core/Throwable->map","lfe.core/accessor","lfe.core/aclone","lfe.core/add-classpath","lfe.core/add-watch","lfe.core/agent","lfe.core/agent-error","lfe.core/agent-errors","lfe.core/aget","lfe.core/alength","lfe.core/alias","lfe.core/all-ns","lfe.core/alter","lfe.core/alter-meta!","lfe.core/alter-var-root","lfe.core/ancestors","lfe.core/apply","lfe.core/array-map","lfe.core/aset","lfe.core/aset-boolean","lfe.core/aset-byte","lfe.core/aset-char","lfe.core/aset-double","lfe.core/aset-float","lfe.core/aset-int","lfe.core/aset-long","lfe.core/aset-short","lfe.core/assoc","lfe.core/assoc!","lfe.core/assoc-in","lfe.core/associative?","lfe.core/atom","lfe.core/await","lfe.core/await-for","lfe.core/await1","lfe.core/bases","lfe.core/bean","lfe.core/bigdec","lfe.core/bigint","lfe.core/biginteger","lfe.core/bit-and","lfe.core/bit-and-not","lfe.core/bit-clear","lfe.core/bit-flip","lfe.core/bit-not","lfe.core/bit-or","lfe.core/bit-set","lfe.core/bit-shift-left","lfe.core/bit-shift-right","lfe.core/bit-test","lfe.core/bit-xor","lfe.core/boolean","lfe.core/boolean-array","lfe.core/booleans","lfe.core/bound-fn*","lfe.core/bound?","lfe.core/butlast","lfe.core/byte","lfe.core/byte-array","lfe.core/bytes","lfe.core/cast","lfe.core/cat","lfe.core/char","lfe.core/char-array","lfe.core/char?","lfe.core/chars","lfe.core/chunk","lfe.core/chunk-append","lfe.core/chunk-buffer","lfe.core/chunk-cons","lfe.core/chunk-first","lfe.core/chunk-next","lfe.core/chunk-rest","lfe.core/chunked-seq?","lfe.core/class","lfe.core/class?","lfe.core/clear-agent-errors","lfe.core/lfe-version","lfe.core/coll?","lfe.core/commute","lfe.core/comp","lfe.core/comparator","lfe.core/compare","lfe.core/compare-and-set!","lfe.core/compile","lfe.core/complement","lfe.core/completing","lfe.core/concat","lfe.core/conj","lfe.core/conj!","lfe.core/cons","lfe.core/constantly","lfe.core/construct-proxy","lfe.core/contains?","lfe.core/count","lfe.core/counted?","lfe.core/create-ns","lfe.core/create-struct","lfe.core/cycle","lfe.core/dec","lfe.core/dec'","lfe.core/decimal?","lfe.core/dedupe","lfe.core/delay?","lfe.core/deliver","lfe.core/denominator","lfe.core/deref","lfe.core/derive","lfe.core/descendants","lfe.core/destructure","lfe.core/disj","lfe.core/disj!","lfe.core/dissoc","lfe.core/dissoc!","lfe.core/distinct","lfe.core/distinct?","lfe.core/doall","lfe.core/dorun","lfe.core/double","lfe.core/double-array","lfe.core/doubles","lfe.core/drop","lfe.core/drop-last","lfe.core/drop-while","lfe.core/eduction","lfe.core/empty","lfe.core/empty?","lfe.core/ensure","lfe.core/ensure-reduced","lfe.core/enumeration-seq","lfe.core/error-handler","lfe.core/error-mode","lfe.core/eval","lfe.core/even?","lfe.core/every-pred","lfe.core/every?","lfe.core/ex-data","lfe.core/ex-info","lfe.core/extend","lfe.core/extenders","lfe.core/extends?","lfe.core/false?","lfe.core/ffirst","lfe.core/file-seq","lfe.core/filter","lfe.core/filterv","lfe.core/find","lfe.core/find-keyword","lfe.core/find-ns","lfe.core/find-protocol-impl","lfe.core/find-protocol-method","lfe.core/find-var","lfe.core/first","lfe.core/flatten","lfe.core/float","lfe.core/float-array","lfe.core/float?","lfe.core/floats","lfe.core/flush","lfe.core/fn?","lfe.core/fnext","lfe.core/fnil","lfe.core/force","lfe.core/format","lfe.core/frequencies","lfe.core/future-call","lfe.core/future-cancel","lfe.core/future-cancelled?","lfe.core/future-done?","lfe.core/future?","lfe.core/gensym","lfe.core/get","lfe.core/get-in","lfe.core/get-method","lfe.core/get-proxy-class","lfe.core/get-thread-bindings","lfe.core/get-validator","lfe.core/group-by","lfe.core/hash","lfe.core/hash-combine","lfe.core/hash-map","lfe.core/hash-ordered-coll","lfe.core/hash-set","lfe.core/hash-unordered-coll","lfe.core/identical?","lfe.core/identity","lfe.core/ifn?","lfe.core/in-ns","lfe.core/inc","lfe.core/inc'","lfe.core/init-proxy","lfe.core/instance?","lfe.core/int","lfe.core/int-array","lfe.core/integer?","lfe.core/interleave","lfe.core/intern","lfe.core/interpose","lfe.core/into","lfe.core/into-array","lfe.core/ints","lfe.core/isa?","lfe.core/iterate","lfe.core/iterator-seq","lfe.core/juxt","lfe.core/keep","lfe.core/keep-indexed","lfe.core/key","lfe.core/keys","lfe.core/keyword","lfe.core/keyword?","lfe.core/last","lfe.core/line-seq","lfe.core/list","lfe.core/list*","lfe.core/list?","lfe.core/load","lfe.core/load-file","lfe.core/load-reader","lfe.core/load-string","lfe.core/loaded-libs","lfe.core/long","lfe.core/long-array","lfe.core/longs","lfe.core/macroexpand","lfe.core/macroexpand-1","lfe.core/make-array","lfe.core/make-hierarchy","lfe.core/map","lfe.core/map-entry?","lfe.core/map-indexed","lfe.core/map?","lfe.core/mapcat","lfe.core/mapv","lfe.core/max","lfe.core/max-key","lfe.core/memoize","lfe.core/merge","lfe.core/merge-with","lfe.core/meta","lfe.core/method-sig","lfe.core/methods","lfe.core/min","lfe.core/min-key","lfe.core/mix-collection-hash","lfe.core/mod","lfe.core/munge","lfe.core/name","lfe.core/namespace","lfe.core/namespace-munge","lfe.core/neg?","lfe.core/newline","lfe.core/next","lfe.core/nfirst","lfe.core/nil?","lfe.core/nnext","lfe.core/not","lfe.core/not-any?","lfe.core/not-empty","lfe.core/not-every?","lfe.core/not=","lfe.core/ns-aliases","lfe.core/ns-imports","lfe.core/ns-interns","lfe.core/ns-map","lfe.core/ns-name","lfe.core/ns-publics","lfe.core/ns-refers","lfe.core/ns-resolve","lfe.core/ns-unalias","lfe.core/ns-unmap","lfe.core/nth","lfe.core/nthnext","lfe.core/nthrest","lfe.core/num","lfe.core/number?","lfe.core/numerator","lfe.core/object-array","lfe.core/odd?","lfe.core/parents","lfe.core/partial","lfe.core/partition","lfe.core/partition-all","lfe.core/partition-by","lfe.core/pcalls","lfe.core/peek","lfe.core/persistent!","lfe.core/pmap","lfe.core/pop","lfe.core/pop!","lfe.core/pop-thread-bindings","lfe.core/pos?","lfe.core/pr","lfe.core/pr-str","lfe.core/prefer-method","lfe.core/prefers","lfe.core/print","lfe.core/print-ctor","lfe.core/print-dup","lfe.core/print-method","lfe.core/print-simple","lfe.core/print-str","lfe.core/printf","lfe.core/println","lfe.core/println-str","lfe.core/prn","lfe.core/prn-str","lfe.core/promise","lfe.core/proxy-call-with-super","lfe.core/proxy-mappings","lfe.core/proxy-name","lfe.core/push-thread-bindings","lfe.core/quot","lfe.core/rand","lfe.core/rand-int","lfe.core/rand-nth","lfe.core/random-sample","lfe.core/range","lfe.core/ratio?","lfe.core/rational?","lfe.core/rationalize","lfe.core/re-find","lfe.core/re-groups","lfe.core/re-matcher","lfe.core/re-matches","lfe.core/re-pattern","lfe.core/re-seq","lfe.core/read","lfe.core/read-line","lfe.core/read-string","lfe.core/reader-conditional","lfe.core/reader-conditional?","lfe.core/realized?","lfe.core/record?","lfe.core/reduce","lfe.core/reduce-kv","lfe.core/reduced","lfe.core/reduced?","lfe.core/reductions","lfe.core/ref","lfe.core/ref-history-count","lfe.core/ref-max-history","lfe.core/ref-min-history","lfe.core/ref-set","lfe.core/refer","lfe.core/release-pending-sends","lfe.core/rem","lfe.core/remove","lfe.core/remove-all-methods","lfe.core/remove-method","lfe.core/remove-ns","lfe.core/remove-watch","lfe.core/repeat","lfe.core/repeatedly","lfe.core/replace","lfe.core/replicate","lfe.core/require","lfe.core/reset!","lfe.core/reset-meta!","lfe.core/resolve","lfe.core/rest","lfe.core/restart-agent","lfe.core/resultset-seq","lfe.core/reverse","lfe.core/reversible?","lfe.core/rseq","lfe.core/rsubseq","lfe.core/run!","lfe.core/satisfies?","lfe.core/second","lfe.core/select-keys","lfe.core/send","lfe.core/send-off","lfe.core/send-via","lfe.core/seq","lfe.core/seq?","lfe.core/seque","lfe.core/sequence","lfe.core/sequential?","lfe.core/set","lfe.core/set-agent-send-executor!","lfe.core/set-agent-send-off-executor!","lfe.core/set-error-handler!","lfe.core/set-error-mode!","lfe.core/set-validator!","lfe.core/set?","lfe.core/short","lfe.core/short-array","lfe.core/shorts","lfe.core/shuffle","lfe.core/shutdown-agents","lfe.core/slurp","lfe.core/some","lfe.core/some-fn","lfe.core/some?","lfe.core/sort","lfe.core/sort-by","lfe.core/sorted-map","lfe.core/sorted-map-by","lfe.core/sorted-set","lfe.core/sorted-set-by","lfe.core/sorted?","lfe.core/special-symbol?","lfe.core/spit","lfe.core/split-at","lfe.core/split-with","lfe.core/str","lfe.core/string?","lfe.core/struct","lfe.core/struct-map","lfe.core/subs","lfe.core/subseq","lfe.core/subvec","lfe.core/supers","lfe.core/swap!","lfe.core/symbol","lfe.core/symbol?","lfe.core/tagged-literal","lfe.core/tagged-literal?","lfe.core/take","lfe.core/take-last","lfe.core/take-nth","lfe.core/take-while","lfe.core/test","lfe.core/the-ns","lfe.core/thread-bound?","lfe.core/to-array","lfe.core/to-array-2d","lfe.core/trampoline","lfe.core/transduce","lfe.core/transient","lfe.core/tree-seq","lfe.core/true?","lfe.core/type","lfe.core/unchecked-add","lfe.core/unchecked-add-int","lfe.core/unchecked-byte","lfe.core/unchecked-char","lfe.core/unchecked-dec","lfe.core/unchecked-dec-int","lfe.core/unchecked-divide-int","lfe.core/unchecked-double","lfe.core/unchecked-float","lfe.core/unchecked-inc","lfe.core/unchecked-inc-int","lfe.core/unchecked-int","lfe.core/unchecked-long","lfe.core/unchecked-multiply","lfe.core/unchecked-multiply-int","lfe.core/unchecked-negate","lfe.core/unchecked-negate-int","lfe.core/unchecked-remainder-int","lfe.core/unchecked-short","lfe.core/unchecked-subtract","lfe.core/unchecked-subtract-int","lfe.core/underive","lfe.core/unreduced","lfe.core/unsigned-bit-shift-right","lfe.core/update","lfe.core/update-in","lfe.core/update-proxy","lfe.core/use","lfe.core/val","lfe.core/vals","lfe.core/var-get","lfe.core/var-set","lfe.core/var?","lfe.core/vary-meta","lfe.core/vec","lfe.core/vector","lfe.core/vector-of","lfe.core/vector?","lfe.core/volatile!","lfe.core/volatile?","lfe.core/vreset!","lfe.core/with-bindings*","lfe.core/with-meta","lfe.core/with-redefs-fn","lfe.core/xml-seq","lfe.core/zero?","lfe.core/zipmap","coll?","commute","comp","comparator","compare","compare-and-set!","compile","complement","completing","concat","conj","conj!","cons","constantly","construct-proxy","contains?","count","counted?","create-ns","create-struct","cycle","dec","dec'","decimal?","dedupe","delay?","deliver","denominator","deref","derive","descendants","destructure","disj","disj!","dissoc","dissoc!","distinct","distinct?","doall","dorun","double","double-array","doubles","drop","drop-last","drop-while","eduction","empty","empty?","ensure","ensure-reduced","enumeration-seq","error-handler","error-mode","eval","even?","every-pred","every?","ex-data","ex-info","extend","extenders","extends?","false?","ffirst","file-seq","filter","filterv","find","find-keyword","find-ns","find-protocol-impl","find-protocol-method","find-var","first","flatten","float","float-array","float?","floats","flush","fn?","fnext","fnil","force","format","frequencies","future-call","future-cancel","future-cancelled?","future-done?","future?","gensym","get","get-in","get-method","get-proxy-class","get-thread-bindings","get-validator","group-by","hash","hash-combine","hash-map","hash-ordered-coll","hash-set","hash-unordered-coll","identical?","identity","ifn?","in-ns","inc","inc'","init-proxy","instance?","int","int-array","integer?","interleave","intern","interpose","into","into-array","ints","isa?","iterate","iterator-seq","juxt","keep","keep-indexed","key","keys","keyword","keyword?","last","line-seq","list","list*","list?","load","load-file","load-reader","load-string","loaded-libs","long","long-array","longs","macroexpand","macroexpand-1","make-array","make-hierarchy","map","map-entry?","map-indexed","map?","mapcat","mapv","max","max-key","memoize","merge","merge-with","meta","method-sig","methods","min","min-key","mix-collection-hash","mod","munge","name","namespace","namespace-munge","neg?","newline","next","nfirst","nil?","nnext","not","not-any?","not-empty","not-every?","not=","ns-aliases","ns-imports","ns-interns","ns-map","ns-name","ns-publics","ns-refers","ns-resolve","ns-unalias","ns-unmap","nth","nthnext","nthrest","num","number?","numerator","object-array","odd?","parents","partial","partition","partition-all","partition-by","pcalls","peek","persistent!","pmap","pop","pop!","pop-thread-bindings","pos?","pr","pr-str","prefer-method","prefers","print","print-ctor","print-dup","print-method","print-simple","print-str","printf","println","println-str","prn","prn-str","promise","proxy-call-with-super","proxy-mappings","proxy-name","push-thread-bindings","quot","rand","rand-int","rand-nth","random-sample","range","ratio?","rational?","rationalize","re-find","re-groups","re-matcher","re-matches","re-pattern","re-seq","read","read-line","read-string","reader-conditional","reader-conditional?","realized?","record?","reduce","reduce-kv","reduced","reduced?","reductions","ref","ref-history-count","ref-max-history","ref-min-history","ref-set","refer","release-pending-sends","rem","remove","remove-all-methods","remove-method","remove-ns","remove-watch","repeat","repeatedly","replace","replicate","require","reset!","reset-meta!","resolve","rest","restart-agent","resultset-seq","reverse","reversible?","rseq","rsubseq","run!","satisfies?","second","select-keys","send","send-off","send-via","seq","seq?","seque","sequence","sequential?","set","set-agent-send-executor!","set-agent-send-off-executor!","set-error-handler!","set-error-mode!","set-validator!","set?","short","short-array","shorts","shuffle","shutdown-agents","slurp","some","some-fn","some?","sort","sort-by","sorted-map","sorted-map-by","sorted-set","sorted-set-by","sorted?","special-symbol?","spit","split-at","split-with","str","string?","struct","struct-map","subs","subseq","subvec","supers","swap!","symbol","symbol?","tagged-literal","tagged-literal?","take","take-last","take-nth","take-while","test","the-ns","thread-bound?","to-array","to-array-2d","trampoline","transduce","transient","tree-seq","true?","type","unchecked-add","unchecked-add-int","unchecked-byte","unchecked-char","unchecked-dec","unchecked-dec-int","unchecked-divide-int","unchecked-double","unchecked-float","unchecked-inc","unchecked-inc-int","unchecked-int","unchecked-long","unchecked-multiply","unchecked-multiply-int","unchecked-negate","unchecked-negate-int","unchecked-remainder-int","unchecked-short","unchecked-subtract","unchecked-subtract-int","underive","unreduced","unsigned-bit-shift-right","update","update-in","update-proxy","use","val","vals","var-get","var-set","var?","vary-meta","vec","vector","vector-of","vector?","volatile!","volatile?","vreset!","with-bindings*","with-meta","with-redefs-fn","xml-seq","zero?","zipmap"]
    \ , 'lfeMacro': ["->","->>","..","amap","and","areduce","as->","assert","binding","bound-fn","lfe.core/->","lfe.core/->>","lfe.core/..","lfe.core/amap","lfe.core/and","lfe.core/areduce","lfe.core/as->","lfe.core/assert","lfe.core/binding","lfe.core/bound-fn","lfe.core/comment","lfe.core/declare","lfe.core/delay","lfe.core/dosync","lfe.core/doto","lfe.core/extend-protocol","lfe.core/extend-type","lfe.core/for","lfe.core/future","lfe.core/gen-class","lfe.core/gen-interface","lfe.core/import","lfe.core/io!","lfe.core/lazy-cat","lfe.core/lazy-seq","lfe.core/letfn","lfe.core/locking","lfe.core/memfn","lfe.core/ns","lfe.core/or","lfe.core/proxy","lfe.core/proxy-super","lfe.core/pvalues","lfe.core/refer-lfe","lfe.core/reify","lfe.core/some->","lfe.core/some->>","lfe.core/sync","lfe.core/time","lfe.core/vswap!","lfe.core/with-bindings","lfe.core/with-in-str","lfe.core/with-loading-context","lfe.core/with-local-vars","lfe.core/with-open","lfe.core/with-out-str","lfe.core/with-precision","lfe.core/with-redefs","comment","declare","delay","dosync","doto","extend-protocol","extend-type","for","future","gen-class","gen-interface","import","io!","lazy-cat","lazy-seq","letfn","locking","memfn","ns","or","proxy","proxy-super","pvalues","refer-lfe","reify","some->","some->>","sync","time","vswap!","with-bindings","with-in-str","with-loading-context","with-local-vars","with-open","with-out-str","with-precision","with-redefs"]
    \ , 'lfeRepeat': ["lfe.core/doseq","lfe.core/dotimes","lfe.core/while","doseq","dotimes","while"]
    \ , 'lfeSpecial': [".","lfe.core/fn","lfe.core/let","lfe.core/loop","def","do","fn","if","let","loop","monitor-enter","monitor-exit","new","quote","recur","set!","var"]
    \ , 'lfeVariable': ["*1","*2","*3","*agent*","*allow-unresolved-vars*","*assert*","*lfe-version*","*command-line-args*","*compile-files*","*compile-path*","*compiler-options*","*data-readers*","*default-data-reader-fn*","*e","*err*","*file*","*flush-on-newline*","*fn-loader*","*in*","*math-context*","*ns*","*out*","*print-dup*","*print-length*","*print-level*","*print-meta*","*print-readably*","*read-eval*","*source-path*","*suppress-read*","*unchecked-math*","*use-context-classloader*","*verbose-defrecords*","*warn-on-reflection*","EMPTY-NODE","char-escape-string","char-name-string","lfe.core/*1","lfe.core/*2","lfe.core/*3","lfe.core/*agent*","lfe.core/*allow-unresolved-vars*","lfe.core/*assert*","lfe.core/*lfe-version*","lfe.core/*command-line-args*","lfe.core/*compile-files*","lfe.core/*compile-path*","lfe.core/*compiler-options*","lfe.core/*data-readers*","lfe.core/*default-data-reader-fn*","lfe.core/*e","lfe.core/*err*","lfe.core/*file*","lfe.core/*flush-on-newline*","lfe.core/*fn-loader*","lfe.core/*in*","lfe.core/*math-context*","lfe.core/*ns*","lfe.core/*out*","lfe.core/*print-dup*","lfe.core/*print-length*","lfe.core/*print-level*","lfe.core/*print-meta*","lfe.core/*print-readably*","lfe.core/*read-eval*","lfe.core/*source-path*","lfe.core/*suppress-read*","lfe.core/*unchecked-math*","lfe.core/*use-context-classloader*","lfe.core/*verbose-defrecords*","lfe.core/*warn-on-reflection*","lfe.core/EMPTY-NODE","lfe.core/char-escape-string","lfe.core/char-name-string","lfe.core/default-data-readers","lfe.core/primitives-classnames","lfe.core/unquote","lfe.core/unquote-splicing","default-data-readers","primitives-classnames","unquote","unquote-splicing"]
    \ }

function! s:syntax_keyword(dict)
	for key in keys(a:dict)
		execute 'syntax keyword' key join(a:dict[key], ' ')
	endfor
endfunction

if exists('b:lfe_syntax_without_core_keywords') && b:lfe_syntax_without_core_keywords
	" Only match language specials and primitives
	for s:key in ['lfeBoolean', 'lfeConstant', 'lfeException', 'lfeSpecial']
		execute 'syntax keyword' s:key join(s:lfe_syntax_keywords[s:key], ' ')
	endfor
else
	call s:syntax_keyword(s:lfe_syntax_keywords)
endif

if exists('g:lfe_syntax_keywords')
	call s:syntax_keyword(g:lfe_syntax_keywords)
endif

if exists('b:lfe_syntax_keywords')
	call s:syntax_keyword(b:lfe_syntax_keywords)
endif

unlet! s:key
delfunction s:syntax_keyword

" Keywords are symbols:
"   static Pattern symbolPat = Pattern.compile("[:]?([\\D&&[^/]].*/)?([\\D&&[^/]][^/]*)");
" But they:
"   * Must not end in a : or /
"   * Must not have two adjacent colons except at the beginning
"   * Must not contain any reader metacharacters except for ' and #
syntax match lfeKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\%/]+/)*[^ \n\r\t()\[\]{}";@^`~\\%/]+:@<!>"

syntax match lfeStringEscape "\v\\%([\\btnfr"]|u\x{4}|[0-3]\o{2}|\o{1,2})" contained

syntax region lfeString matchgroup=lfeStringDelimiter start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=lfeStringEscape,@Spell

syntax match lfeCharacter "\\."
syntax match lfeCharacter "\\o\%([0-3]\o\{2\}\|\o\{1,2\}\)"
syntax match lfeCharacter "\\u\x\{4\}"
syntax match lfeCharacter "\\space"
syntax match lfeCharacter "\\tab"
syntax match lfeCharacter "\\newline"
syntax match lfeCharacter "\\return"
syntax match lfeCharacter "\\backspace"
syntax match lfeCharacter "\\formfeed"

syntax match lfeSymbol "\v%([a-zA-Z!$&*_+=|<.>?-]|[^\x00-\x7F])+%(:?%([a-zA-Z0-9!#$%&*_+=|'<.>/?-]|[^\x00-\x7F]))*[#:]@<!"

let s:radix_chars = "0123456789abcdefghijklmnopqrstuvwxyz"
for s:radix in range(2, 36)
	execute 'syntax match lfeNumber "\v\c<[-+]?' . s:radix . 'r[' . strpart(s:radix_chars, 0, s:radix) . ']+>"'
endfor
unlet! s:radix_chars s:radix

syntax match lfeNumber "\v<[-+]?%(0\o*|0x\x+|[1-9]\d*)N?>"
syntax match lfeNumber "\v<[-+]?%(0|[1-9]\d*|%(0|[1-9]\d*)\.\d*)%(M|[eE][-+]?\d+)?>"
syntax match lfeNumber "\v<[-+]?%(0|[1-9]\d*)/%(0|[1-9]\d*)>"

syntax match lfeVarArg "&"

syntax match lfeQuote "'"
syntax match lfeQuote "`"
syntax match lfeUnquote "\~"
syntax match lfeUnquote "\~@"
syntax match lfeMeta "\^"
syntax match lfeDeref "@"
syntax match lfeDispatch "\v#[\^'=<_]?"

" Clojure permits no more than 20 anonymous params.
syntax match lfeAnonArg "%\(20\|1\d\|[1-9]\|&\)\?"

syntax match  lfeRegexpEscape "\v\\%([\\tnrfae.()\[\]{}^$*?+]|c\u|0[0-3]?\o{1,2}|x%(\x{2}|\{\x{1,6}\})|u\x{4})" contained display
syntax region lfeRegexpQuoted start=/\\Q/ms=e+1 skip=/\\\\\|\\"/ end=/\\E/me=s-1 end=/"/me=s-1 contained
syntax region lfeRegexpQuote  start=/\\Q/       skip=/\\\\\|\\"/ end=/\\E/       end=/"/me=s-1 contains=lfeRegexpQuoted keepend contained

" -*- CHARACTER PROPERTY CLASSES -*-
" Generated from https://github.com/guns/vim-lfe-static/blob/%%RELEASE_TAG%%/clj/src/vim_lfe_static/generate.clj
" Java version 1.8.0_92
syntax match lfeRegexpPosixCharClass "\v\\[pP]\{%(Cntrl|A%(l%(pha|num)|SCII)|Space|Graph|Upper|P%(rint|unct)|Blank|XDigit|Digit|Lower)\}" contained display
syntax match lfeRegexpJavaCharClass "\v\\[pP]\{java%(Whitespace|JavaIdentifier%(Part|Start)|SpaceChar|Mirrored|TitleCase|I%(SOControl|de%(ographic|ntifierIgnorable))|D%(efined|igit)|U%(pperCase|nicodeIdentifier%(Part|Start))|L%(etter%(OrDigit)?|owerCase)|Alphabetic)\}" contained display
syntax match lfeRegexpUnicodeCharClass "\v\\[pP]\{\cIs%(l%(owercase|etter)|hex%(digit|_digit)|w%(hite%(_space|space)|ord)|noncharacter%(_code_point|codepoint)|p%(rint|unctuation)|ideographic|graph|a%(l%(num|phabetic)|ssigned)|uppercase|join%(control|_control)|titlecase|blank|digit|control)\}" contained display
syntax match lfeRegexpUnicodeCharClass "\v\\[pP][NSCMZPL]" contained display
syntax match lfeRegexpUnicodeCharClass "\v\\[pP]\{%(N[dlo]?|P[dcifeos]?|C[ncfos]?|M[nce]?|Z[lsp]?|S[mcko]?|L[muCDlto]?)\}" contained display
syntax match lfeRegexpUnicodeCharClass "\v\\[pP]\{%(Is|gc\=|general_category\=)?%(N[dlo]?|P[dcifeos]?|C[ncfos]?|M[nce]?|Z[lsp]?|S[mcko]?|L[muCDlto]?)\}" contained display
syntax match lfeRegexpUnicodeCharClass "\v\\[pP]\{\c%(Is|sc\=|script\=)%(l%(epc%(ha)?|y%([dc]i%(an)?)|a%(t%(n|in)|na|oo?)|i%(n%(b|ear_b)|mbu?|su))|p%(rti|lrd|h%(oenician|li|ag%(s_pa)?|nx))|vaii?|d%(srt|e%(seret|va%(nagari)?))|g%(lag%(olitic)?|eor%(gian)?|oth%(ic)?|re%(k|ek)|u%(j%(arati|r)|r%(u|mukhi)))|u%(gar%(itic)?|nknown)|a%(r%(ab%(ic)?|m%([ni]|enian))|v%(st|estan))|e%(thi%(opic)?|gyp%(tian_hieroglyphs)?)|z%(inh|yyy|zzz)|r%(un%(ic|r)|ejang|jng)|s%(inh%(ala)?|h%(rd|a%(vian|rada|w))|a%(ur%(ashtra)?|m%(r|aritan)|rb)|y%(r%(c|iac)|lo%(ti_nagri)?)|und%(anese)?|ora%(_sompeng)?)|i%(n%(scriptional_pa%(rthian|hlavi)|herited)|mperial_aramaic|tal)|b%(eng%(ali)?|a%(t%(ak|k)|li%(nese)?|mum?)|ra%(i%(lle)?|h%(mi)?)|opo%(mofo)?|u%(gi%(nese)?|h%(d|id)))|o%(g%(am|ham)|r%(iya|kh|ya)|sma%(nya)?|l%(d_%(south_arabian|persian|italic|turkic)|ck|_chiki))|k%(h%(m%(r|er)|ar%(oshthi)?)|nda|a%(li|n%(a|nada)|takana|yah_li|ithi)|thi)|m%(a%(nd%(aic)?|layalam)|lym|y%(anmar|mr)|tei|e%(r%(c|o%(itic_%(hieroglyphs|cursive))?)|etei_mayek)|ong%(olian)?|iao)|yi%(ii)?|x%(peo|sux)|n%(ew_tai_lue|koo?)|h%(ira%(gana)?|an%([io]|unoo|g%(ul)?)?|ebr%(ew)?)|c%(y%(priot|r%(l|illic))|a%(km|n%(adian_aboriginal|s)|ri%(an)?)|prt|h%(er%(okee)?|a%(m|kma))|uneiform|o%(pt%(ic)?|mmon))|t%(elu%(gu)?|i%(finagh|b%(t|etan))|ha%(i|a%(na)?)|a%(i_%(le|tham|viet)|g%(alog|b%(anwa)?)|vt|kri?|l[ue]|m%(il|l))|fng|glg)|java%(nese)?)\}" contained display
syntax match lfeRegexpUnicodeCharClass "\v\\[pP]\{\c%(In|blk\=|block\=)%(javanese|h%(a%(lfwidth%( and fullwidth forms|andfullwidthforms|_and_fullwidth_forms)|n%(unoo|gul%(compatibilityjamo|syllables|jamo%(extended\-[ab])?|_%(syllables|jamo%(_extended_[ab])?|compatibility_jamo)| %(syllables|compatibility jamo|jamo%( extended\-[ab])?))))|i%(ragana|gh%( %(private use surrogates|surrogates)|_%(private_use_surrogates|surrogates)|surrogates|privateusesurrogates))|ebrew)|i%(pa%([ _]extensions|extensions)|deographic%( description characters|_description_characters|descriptioncharacters)|nscriptional%(%([ _]pa%(rthian|hlavi))|pa%(rthian|hlavi))|mperial%(aramaic|[_ ]aramaic))|l%(e%(tterlike%([_ ]symbols|symbols)|pcha)|ow%([_ ]surrogates|surrogates)|i%(mbu|near%(_b_%(ideograms|syllabary)|b%(ideograms|syllabary)| b %(ideograms|syllabary))|su)|a%(tin%(extended%(additional|\-[dacb])| extended%( additional|\-[dacb])|\-1%(supplement| supplement)|_%(extended_%([dcb]|a%(dditional)?)|1_supplement))|o)|y[cd]ian)|b%(u%(ginese|hid)|ra%(hmi|ille%(patterns|[_ ]patterns))|o%(x%([ _]drawing|drawing)|pomofo%([ _]extended|extended)?)|lock%([ _]elements|elements)|yzantine%( musical symbols|musicalsymbols|_musical_symbols)|engali|a%(linese|mum%(supplement|[ _]supplement)?|tak|sic%([ _]latin|latin)))|e%(gyptian%([ _]hieroglyphs|hieroglyphs)|moticons|nclosed%( %(cjk letters and months|ideographic supplement|alphanumeric%( supplement|s))|cjklettersandmonths|_%(ideographic_supplement|alphanumeric%(_supplement|s)|cjk_letters_and_months)|alphanumerics%(upplement)?|ideographicsupplement)|thiopic%(supplement|_%(supplement|extended%(_a)?)| %(supplement|extended%(\-a)?)|extended%(\-a)?)?)|k%(h%(aroshthi|mer%([_ ]symbols|symbols)?)|a%(takana%(_phonetic_extensions|phoneticextensions| phonetic extensions)?|n%(gxi%([_ ]radicals|radicals)|a%(supplement|[ _]supplement)|bun|nada)|ithi|yah%([ _]li|li)))|m%(i%(ao|scellaneous%(technical|symbols%(and%(pictographs|arrows))?|mathematicalsymbols\-[ab]| %(technical|mathematical symbols\-[ab]|symbols%( and %(pictographs|arrows))?)|_%(technical|symbols%(_and_%(pictographs|arrows))?|mathematical_symbols_[ab])))|usical%([_ ]symbols|symbols)|e%(etei%(mayek%(extensions)?|_mayek%(_extensions)?| mayek%( extensions)?)|roitic%(hieroglyphs|%([_ ]%(hieroglyphs|cursive))|cursive))|a%(ndaic|hjong%([ _]tiles|tiles)|layalam|thematical%(alphanumericsymbols| %(alphanumeric symbols|operators)|_%(alphanumeric_symbols|operators)|operators))|yanmar%(extended\-a|_extended_a| extended\-a)?|o%(difier%(_tone_letters| tone letters|toneletters)|ngolian))|r%(u%(nic|mi%(numeralsymbols| numeral symbols|_numeral_symbols))|ejang)|n%(umber%(forms|[ _]forms)|ko|ew%(_tai_lue|tailue| tai lue))|c%(o%(ntrol%(pictures|[ _]pictures)|m%(bining%(diacriticalmarks%(supplement|forsymbols)?|halfmarks| %(diacritical marks%( %(supplement|for symbols))?|half marks|marks for symbols)|marksforsymbols|_%(marks_for_symbols|half_marks|diacritical_marks%(_supplement)?))|mon%(_indic_number_forms|indicnumberforms| indic number forms))|ptic|unting%( rod numerals|_rod_numerals|rodnumerals))|y%(rillic%(extended\-[ab]|_%(extended_[ab]|supplementary)|supplement%(ary)?| %(extended\-[ab]|supplement%(ary)?))?|priot%(syllabary|[ _]syllabary))|u%(rrency%([_ ]symbols|symbols)|neiform%(_numbers_and_punctuation|numbersandpunctuation| numbers and punctuation)?)|h%(a%(m|kma)|erokee)|arian|jk%(s%(ymbolsandpunctuation|trokes)|compatibility%(forms|ideographs%(supplement)?)?|radicalssupplement| %(compatibility%( %(ideographs%( supplement)?|forms))?|radicals supplement|unified ideographs%( extension [dacb])?|s%(ymbols and punctuation|trokes))|_%(s%(trokes|ymbols_and_punctuation)|radicals_supplement|compatibility%(_%(forms|ideographs%(_supplement)?))?|unified_ideographs%(_extension_[dacb])?)|unifiedideographs%(extension[dacb])?))|d%(e%(seret|vanagari%([ _]extended|extended)?)|ingbats|omino%([ _]tiles|tiles))|yi%(syllables|%([_ ]%(syllables|radicals))|radicals|jing%(hexagramsymbols| hexagram symbols|_hexagram_symbols))|s%(mall%( form variants|formvariants|_form_variants)|p%(acing%(_modifier_letters| modifier letters|modifierletters)|ecials)|ora%(sompeng|[ _]sompeng)|ha%(vian|rada)|a%(maritan|urashtra)|inhala|y%(riac|loti%([_ ]nagri|nagri))|u%(ndanese%(supplement|[ _]supplement)?|p%(erscripts%(_and_subscripts|andsubscripts| and subscripts)|plementa%(ry%(_private_use_area_[ab]|privateusearea\-[ab]| private use area\-[ab])|l%(_%(arrows_[ab]|mathematical_operators|punctuation)| %(mathematical operators|punctuation|arrows\-[ab])|mathematicaloperators|punctuation|arrows\-[ab])))|rrogates_area))|p%(h%(o%(enician|netic%( extensions%( supplement)?|extensions%(supplement)?|_extensions%(_supplement)?))|a%(istos%([ _]disc|disc)|gs[_\-]pa))|laying%(cards|[_ ]cards)|rivate%(usearea| use area|_use_area))|o%(smanya|l%([ _]chiki|d%( %(south arabian|persian|italic|turkic)|southarabian|_%(south_arabian|persian|italic|turkic)|persian|italic|turkic)|chiki)|riya|ptical%( character recognition|_character_recognition|characterrecognition)|gham)|g%(u%(jarati|rmukhi)|othic|lagolitic|e%(o%(rgian%(supplement|[ _]supplement)?|metric%(shapes|[ _]shapes))|neral%([_ ]punctuation|punctuation))|reek%( %(and coptic|extended)|andcoptic|_extended|extended)?)|t%(i%(betan|finagh)|elugu|ransport%( and map symbols|_and_map_symbols|andmapsymbols)|a%(mil|kri|i%(xuanjingsymbols|_%(le|xuan_jing_symbols|tham|viet)|le| %(xuan jing symbols|le|tham|viet)|tham|viet)|g%(alog|s|banwa))|ha%(i|ana))|a%(l%(chemical%([_ ]symbols|symbols)|phabetic%( presentation forms|_presentation_forms|presentationforms))|r%(menian|abic%(extended\-a|mathematicalalphabeticsymbols|supplement|_%(presentation_forms_[ab]|supplement|extended_a|mathematical_alphabetic_symbols)| %(extended\-a|mathematical alphabetic symbols|supplement|presentation forms\-[ab])|presentationforms\-[ab])?|rows)|ncient%(_%(greek_%(musical_notation|numbers)|symbols)|greek%(numbers|musicalnotation)| %(greek %(numbers|musical notation)|symbols)|symbols)|egean%(numbers|[ _]numbers)|vestan)|u%(garitic|nified%(canadianaboriginalsyllabics%(extended)?|_canadian_aboriginal_syllabics%(_extended)?| canadian aboriginal syllabics%( extended)?))|v%(a%(i|riation%( selectors%( supplement)?|selectors%(supplement)?|_selectors%(_supplement)?))|e%(rtical%(forms|[ _]forms)|dic%([ _]extensions|extensions))))\}" contained display

syntax match   lfeRegexpPredefinedCharClass "\v%(\\[dDsSwW]|\.)" contained display
syntax cluster lfeRegexpCharPropertyClasses contains=lfeRegexpPosixCharClass,lfeRegexpJavaCharClass,lfeRegexpUnicodeCharClass
syntax cluster lfeRegexpCharClasses         contains=lfeRegexpPredefinedCharClass,lfeRegexpCharClass,@lfeRegexpCharPropertyClasses
syntax region  lfeRegexpCharClass           start="\[" skip=/\\\\\|\\]/ end="]" contained contains=lfeRegexpPredefinedCharClass,@lfeRegexpCharPropertyClasses
syntax match   lfeRegexpBoundary            "\\[bBAGZz]" contained display
syntax match   lfeRegexpBoundary            "[$^]" contained display
syntax match   lfeRegexpQuantifier          "[?*+][?+]\=" contained display
syntax match   lfeRegexpQuantifier          "\v\{\d+%(,|,\d+)?}\??" contained display
syntax match   lfeRegexpOr                  "|" contained display
syntax match   lfeRegexpBackRef             "\v\\%([1-9]\d*|k\<[a-zA-z]+\>)" contained display

" Mode modifiers, mode-modified spans, lookaround, regular and atomic
" grouping, and named-capturing.
syntax match lfeRegexpMod "\v\(@<=\?:" contained display
syntax match lfeRegexpMod "\v\(@<=\?[xdsmiuU]*-?[xdsmiuU]+:?" contained display
syntax match lfeRegexpMod "\v\(@<=\?%(\<?[=!]|\>)" contained display
syntax match lfeRegexpMod "\v\(@<=\?\<[a-zA-Z]+\>" contained display

syntax region lfeRegexpGroup start="(" skip=/\\\\\|\\)/ end=")" matchgroup=lfeRegexpGroup contained contains=lfeRegexpMod,lfeRegexpQuantifier,lfeRegexpBoundary,lfeRegexpEscape,@lfeRegexpCharClasses
syntax region lfeRegexp start=/\#"/ skip=/\\\\\|\\"/ end=/"/ contains=@lfeRegexpCharClasses,lfeRegexpEscape,lfeRegexpQuote,lfeRegexpBoundary,lfeRegexpQuantifier,lfeRegexpOr,lfeRegexpBackRef,lfeRegexpGroup keepend

syntax keyword lfeCommentTodo contained FIXME XXX TODO FIXME: XXX: TODO:

syntax match lfeComment ";.*$" contains=lfeCommentTodo,@Spell
syntax match lfeComment "#!.*$"

" -*- TOP CLUSTER -*-
" Generated from https://github.com/guns/vim-lfe-static/blob/%%RELEASE_TAG%%/clj/src/vim_lfe_static/generate.clj
syntax cluster lfeTop contains=@Spell,lfeAnonArg,lfeBoolean,lfeCharacter,lfeComment,lfeCond,lfeConstant,lfeDefine,lfeDeref,lfeDispatch,lfeError,lfeException,lfeFunc,lfeKeyword,lfeMacro,lfeMap,lfeMeta,lfeNumber,lfeQuote,lfeRegexp,lfeRepeat,lfeSexp,lfeSpecial,lfeString,lfeSymbol,lfeUnquote,lfeVarArg,lfeVariable,lfeVector

syntax region lfeSexp   matchgroup=lfeParen start="("  end=")" contains=@lfeTop fold
syntax region lfeVector matchgroup=lfeParen start="\[" end="]" contains=@lfeTop fold
syntax region lfeMap    matchgroup=lfeParen start="{"  end="}" contains=@lfeTop fold

" Highlight superfluous closing parens, brackets and braces.
syntax match lfeError "]\|}\|)"

syntax sync fromstart

highlight default link lfeConstant                  Constant
highlight default link lfeBoolean                   Boolean
highlight default link lfeCharacter                 Character
highlight default link lfeKeyword                   Keyword
highlight default link lfeNumber                    Number
highlight default link lfeString                    String
highlight default link lfeStringDelimiter           String
highlight default link lfeStringEscape              Character

highlight default link lfeRegexp                    Constant
highlight default link lfeRegexpEscape              Character
highlight default link lfeRegexpCharClass           SpecialChar
highlight default link lfeRegexpPosixCharClass      lfeRegexpCharClass
highlight default link lfeRegexpJavaCharClass       lfeRegexpCharClass
highlight default link lfeRegexpUnicodeCharClass    lfeRegexpCharClass
highlight default link lfeRegexpPredefinedCharClass lfeRegexpCharClass
highlight default link lfeRegexpBoundary            SpecialChar
highlight default link lfeRegexpQuantifier          SpecialChar
highlight default link lfeRegexpMod                 SpecialChar
highlight default link lfeRegexpOr                  SpecialChar
highlight default link lfeRegexpBackRef             SpecialChar
highlight default link lfeRegexpGroup               lfeRegexp
highlight default link lfeRegexpQuoted              lfeString
highlight default link lfeRegexpQuote               lfeRegexpBoundary

highlight default link lfeVariable                  Identifier
highlight default link lfeCond                      Conditional
highlight default link lfeDefine                    Define
highlight default link lfeException                 Exception
highlight default link lfeFunc                      Function
highlight default link lfeMacro                     Macro
highlight default link lfeRepeat                    Repeat

highlight default link lfeSpecial                   Special
highlight default link lfeVarArg                    Special
highlight default link lfeQuote                     SpecialChar
highlight default link lfeUnquote                   SpecialChar
highlight default link lfeMeta                      SpecialChar
highlight default link lfeDeref                     SpecialChar
highlight default link lfeAnonArg                   SpecialChar
highlight default link lfeDispatch                  SpecialChar

highlight default link lfeComment                   Comment
highlight default link lfeCommentTodo               Todo

highlight default link lfeError                     Error

highlight default link lfeParen                     Delimiter

let b:current_syntax = "lfe"

let &cpo = s:cpo_sav
unlet! s:cpo_sav

" vim:sts=8:sw=8:ts=8:noet
