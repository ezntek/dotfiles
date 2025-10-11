" XXX: 75% OF THIS SYNTAX FILE IS WRITTEN BY GPT 5.0.
" this work is not mine, but is from an LLM. therefore, it is put under the
" public domain. I will continue to maintain it with manual fixes if needed.
" There is one thing that will never change -- I will not learn RegEx.
" --------

" bc.vim — Syntax highlighting for IGCSE pseudocode + beancode extensions

if exists("b:current_syntax")
  finish
endif

syn case ignore

syn region bcComment start="//" end="$" containedin=ALL
syn region bcComment start="/\*" end="\*/" containedin=ALL
hi def link bcComment Comment

syn region bcString start=+"+ skip=+\\."+ end=+"+ contains=bcEscape
syn region bcChar start=+'+ skip=+\\'+ end=+'+ contains=bcEscape
syn match bcEscape "\\." contained
syn match bcNumber "\<\d\+\(\.\d*\)\=\([eE][+-]\=\d\+\)\=\>"
syn match bcNumber "\<\.\d\+\([eE][+-]\=\d\+\)\=\>"
hi def link bcNumber Number

syn keyword bcKeyword DECLARE OUTPUT INPUT AND OR NOT IF THEN ELSE ENDIF
syn keyword bcKeyword CASE OF OTHERWISE ENDCASE WHILE DO ENDWHILE REPEAT UNTIL
syn keyword bcKeyword FOR TO STEP NEXT PROCEDURE ENDPROCEDURE CALL FUNCTION RETURN
syn keyword bcKeyword RETURNS ENDFUNCTION INCLUDE INCLUDE_FFI EXPORT SCOPE ENDSCOPE
syn keyword bcKeyword PRINT CONSTANT
syn keyword bcKeyword ARRAY "color it the same as keywords for aesthetics

" builtins
syn keyword bcBuiltin UCASE LCASE DIV MOD SUBSTRING ROUND SQRT LENGTH GETCHAR RANDOM PUTCHAR EXIT SLEEP FLUSH SIN COS TAN containedin=ALLBUT,bcComment,bcString,bcChar

" link builtins to Number so they share the same orange color
hi def link bcBuiltin Number

syn keyword bcKeyword FUNCTION nextgroup=bcFuncName skipwhite
syn match bcFuncName "\<[A-Za-z_][A-Za-z0-9_]*\>" contained

syn keyword bcKeyword PROCEDURE nextgroup=bcProcName skipwhite
syn match bcProcName "\<[A-Za-z_][A-Za-z0-9_]*\>" contained

syn keyword bcKeyword CALL nextgroup=bcCallName skipwhite
syn match bcCallName "\<[A-Za-z_][A-Za-z0-9_]*\>" contained

" Function calls without CALL keyword
" Detect patterns like Name(Arg1, Arg2)
" To avoid false positives, ensure Name starts with a letter
syn match bcCallName "\<[A-Za-z_][A-Za-z0-9_]*\>\s*("me=e-1

hi def link bcFuncName Function
hi def link bcProcName Function
hi def link bcCallName Function

syn keyword bcType INTEGER REAL BOOLEAN STRING CHAR NULL
syn keyword bcBoolean TRUE FALSE

syn match bcAssign "<-"
syn match bcOperator "<="
syn match bcOperator ">="
syn match bcOperator "<>"
syn match bcOperator "[←<>=\*\+\-\/\^]"

syn match bcDelimiter "[\{\}\[\]\(\),:;]"

hi def link bcString String
hi def link bcChar Character
hi def link bcEscape Special
hi def link bcNumber Number
hi def link bcKeyword Keyword
hi def link bcType Type
hi def link bcBoolean Boolean
hi def link bcAssign Operator
hi def link bcOperator Operator
hi def link bcDelimiter Delimiter

let b:current_syntax = "bc"
