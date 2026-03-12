; Comments
(comment) @comment

; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "<"
  ">"
] @punctuation.bracket

[
  ","
] @punctuation.delimiter

; Literals
(bool_lit) @boolean

[
  (int_lit)
  (uint_lit)
] @number

[
  (ascii_string_lit)
  (utf8_string_lit)
] @string

[
  (buffer_lit)
  (standard_principal_lit)
  (contract_principal_lit)
] @string.special

; Types
[
  (native_type)
  (trait_type)
] @type

; Keywords — value constructors
(some_lit ("some") @keyword)
(response_lit [
  "ok"
  "err"
] @keyword)
[
  (none_lit)
  (list_lit_token)
] @keyword

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "mod"
  "pow"
  "<"
  "<="
  ">"
  ">="
  "and"
  "or"
  "xor"
] @operator

; Built-in functions
(basic_native_form operator: (native_identifier) @function.builtin)

; Control flow
[
  "let"
] @keyword

; Definition keywords
[
  "impl-trait"
  "use-trait"
  "define-trait"
  "define-read-only"
  "define-private"
  "define-public"
  "define-data-var"
  "define-fungible-token"
  "define-non-fungible-token"
  "define-constant"
  "define-map"
] @keyword.definition

; User-defined functions
(function_signature (identifier) @function.definition)
(function_signature_for_trait (identifier) @function.definition)
(contract_function_call operator: (identifier) @function)

; Properties (tuple keys)
(tuple_lit key: (identifier) @property)

; Variables
(function_parameter) @variable.parameter
(global) @constant.builtin
