" Language:     Orogen configuration files
" Maintainer:   Felix Glinka <devglinka at posteo dot eu>
" URL:          https://github.com/fglinka/vim-orogen
" License:      Public Domain
" Based on the guide at https://vim.fandom.com/wiki/Creating_your_own_syntax_files

if exists("b:current_syntax")
    finish
endif

" Comments
syn keyword orogenTodo TODO FIXME XXX contained
syn match orogenComment "#.*$" contains=orogenTodo

" Strings and numbers
syn region orogenString start='"' skip='\\"' end='"'
syn region orogenString start="'" skip="\\'" end="'"
" Somewhat borrowed from the default lua syntax file
syn match orogenFreq "\<\d\+\>"
syn match orogenFreq "\<\d\+\.\d*\>"
syn match orogenFreq "\.\d\+\>"

" Keywords used outside of a task context
syn keyword orogenToplevelKeywords name version using_library import_types_from nextgroup=orogenString

" Instructions used inside task definitions
syn keyword orogenTaskDefinitionKeywords property input_port output_port needs_configuration contained
syn keyword orogenTaskDefinitionKeywords port_driven nextgroup=orogenString skipwhite contained
syn keyword orogenTaskDefinitionKeywords periodic  nextgroup=orogenFreq skipwhite contained

" Regions for task contexts
syn region orogenTaskContent transparent matchgroup=orogenStatement start="\<do\>" end="\<end\>" contains=ALLBUT,orogenToplevelKeywords
syn region orogenTaskDefinition transparent matchgroup=orogenStatement start="\<task_context\>" end="\<do\>"me=e-2 contains=orogenString nextgroup=orogenTaskContent

let b:current_syntax = "orogen"

hi def link orogenTodo Todo
hi def link orogenComment Comment
hi def link orogenString String
hi def link orogenFreq Number
hi def link orogenToplevelKeywords Function
hi def link orogenStatement Conditional
hi def link orogenTaskDefinitionKeywords Function
