-- Quit if already loaded
if vim.b.current_syntax then
  return
end

vim.cmd("syntax case match")

-- Go escapes
vim.cmd([[
syntax match goEscapeOctal  display contained "\\[0-7]\{3}"
syntax match goEscapeC      display contained +\\[abfnrtv\\'"]+
syntax match goEscapeX      display contained "\\x\x\{2}"
syntax match goEscapeU      display contained "\\u\x\{4}"
syntax match goEscapeBigU   display contained "\\U\x\{8}"
syntax match goEscapeError  display contained +\\[^0-7xuUabfnrtv\\'"]+

highlight def link goEscapeOctal  goSpecialString
highlight def link goEscapeC      goSpecialString
highlight def link goEscapeX      goSpecialString
highlight def link goEscapeU      goSpecialString
highlight def link goEscapeBigU   goSpecialString
highlight def link goSpecialString Special
highlight def link goEscapeError Error

syntax cluster goStringGroup contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syntax region  goString contained start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup
syntax region  goRawString contained start=+`+ end=+`+

highlight def link goString    String
highlight def link goRawString String

syntax cluster goCharacterGroup contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU
syntax region  goCharacter contained start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

highlight def link goCharacter Character

syntax match goDecimalInt     contained "\<\d\+\([Ee]\d\+\)\?\>"
syntax match goHexadecimalInt contained "\<0x\x\+\>"
syntax match goOctalInt       contained "\<0\o\+\>"
syntax match goOctalError     contained "\<0\o*[89]\d*\>"
syntax cluster goInt contains=goDecimalInt,goHexadecimalInt,goOctalInt

syntax match goFloat contained "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syntax match goFloat contained "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syntax match goFloat contained "\<\d\+[Ee][-+]\d\+\>"

syntax match goImaginary contained "\<\d\+i\>"
syntax match goImaginary contained "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syntax match goImaginary contained "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syntax match goImaginary contained "\<\d\+[Ee][-+]\d\+i\>"

highlight def link goInt       Number
highlight def link goFloat     Number
highlight def link goImaginary Number

syntax cluster gotplLiteral contains=goString,goRawString,goCharacter,@goInt,goFloat,goImaginary

syntax keyword gotplControl   contained if else end range with template
syntax keyword gotplFunctions contained and html index js len not or print printf println urlquery eq ne lt le gt ge

syntax match gotplVariable   contained /\$[a-zA-Z0-9_]*\>/
syntax match goTplIdentifier contained /\.[^[:blank:]}]\+\>/

highlight def link gotplControl   Keyword
highlight def link gotplFunctions Function
highlight def link gotplVariable  Special

syntax region gotplAction  start="{{" end="}}" contains=@gotplLiteral,gotplControl,gotplFunctions,gotplVariable,goTplIdentifier display
syntax region goTplComment start="{{\(- \)\?/\*" end="\*/\( -\)\?}}" display

highlight def link gotplAction  PreProc
highlight def link goTplComment Comment
]])

vim.b.current_syntax = "gotexttmpl"
