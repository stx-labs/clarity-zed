; Tree-sitter highlight queries for Clarity
; Each rule maps a tree-sitter grammar node to a Zed highlight capture (@name).
; Zed uses hierarchical resolution: @function.builtin falls back to @function
; if the theme doesn't define a style for function.builtin.

; Comments — line comments starting with ;;
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

; Buffers (0xABCD) and principals ('SP..., .contract-name)
[
  (buffer_lit)
  (standard_principal_lit)
  (contract_principal_lit)
] @string.special

; Type annotations — e.g. int, uint, bool, principal, (buff 20), <trait-name>
[
  (native_type)
  (trait_type)
] @type

; Value constructor keywords — some, ok, err, none, list
(some_lit "some" @keyword)
(response_lit [
  "ok"
  "err"
] @keyword)
[
  (none_lit)
  (list_lit_token)
] @keyword

; Arithmetic, comparison, and logical operators
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
  "not"
  "xor"
] @operator

; Built-in functions — native Clarity functions like map-get?, fold, stx-transfer?, etc.
(basic_native_form operator: (native_identifier) @function.builtin)

; Control flow
[
  "let"
] @keyword

; Top-level definition keywords
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

; User-defined function names — in definitions and call sites
(function_signature (identifier) @function.definition)
(function_signature_for_trait (identifier) @function.definition)
(contract_function_call operator: (identifier) @function)

; Names introduced by top-level definitions
; e.g. MY-CONST in (define-constant MY-CONST u100)
(constant_definition (identifier) @constant)
(variable_definition (identifier) @variable)
(mapping_definition (identifier) @variable)
(fungible_token_definition (identifier) @type)
(non_fungible_token_definition (identifier) @type)
(trait_definition (identifier) @type)
(trait_usage (identifier) @type)

; Local variable bindings inside (let ...)
(local_binding (identifier) @variable)

; Tuple field keys — e.g. "name" in { name: "Alice" } or { name: (string-ascii 50) }
(tuple_lit key: (identifier) @property)
(tuple_type key: (identifier) @property)
(tuple_type_for_trait key: (identifier) @property)

; Function parameters — e.g. (amount uint) in a function signature
(function_parameter (identifier) @variable.parameter)

; Built-in global constants — tx-sender, block-height, stx-liquid-supply, etc.
(global) @constant.builtin
