" beancode.vim — Indentation rules for Beancode pseudocode

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetBeancodeIndent(v:lnum)
setlocal indentkeys=o,O,0<:>,0=ENDIF,0=ENDWHILE,0=ENDCASE,0=ENDPROCEDURE,0=ENDFUNCTION,0=NEXT,0=ENDSCOPE,0=UNTIL

function! GetBeancodeIndent(lnum)
  " Get current and previous nonblank lines
  let lnum = a:lnum
  let prev = prevnonblank(lnum - 1)
  if prev == 0
    return 0
  endif

  let line = getline(lnum)
  let prevline = getline(prev)

  " Default indentation step
  let shift = &shiftwidth
  let indent = indent(prev)

  " Decrease indent for ending blocks
  if line =~? '^\s*\(ENDIF\|ENDWHILE\|ENDCASE\|ENDPROCEDURE\|ENDFUNCTION\|NEXT\|ENDSCOPE\|UNTIL\)'
    return indent - shift
  endif

  " Increase indent for starting blocks
  if prevline =~? '^\s*\(IF\|WHILE\|CASE\|FOR\|PROCEDURE\|FUNCTION\|SCOPE\)\>'
    return indent + shift
  endif
  if prevline =~? '^\s*\(ELSE\|OF\|THEN\)\>'
    return indent + shift
  endif

  return indent
endfunction
