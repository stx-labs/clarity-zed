; Outline queries for Clarity
; Patterns matched with @name and @item appear in Zed's symbol outline panel
; and breadcrumb bar, enabling quick navigation via Cmd+Shift+O.
; @item (required) marks the full node range; @name (required) is the display text.
; @context (optional) adds keyword prefixes like "define-public" to the label.

; Function definitions
(private_function
  "define-private" @context
  (function_signature (identifier) @name)) @item

(read_only_function
  "define-read-only" @context
  (function_signature (identifier) @name)) @item

(public_function
  "define-public" @context
  (function_signature (identifier) @name)) @item

; Constants, variables, and maps
(constant_definition
  "define-constant" @context
  (identifier) @name) @item

(variable_definition
  "define-data-var" @context
  (identifier) @name) @item

(mapping_definition
  "define-map" @context
  (identifier) @name) @item

; Token definitions
(fungible_token_definition
  "define-fungible-token" @context
  (identifier) @name) @item

(non_fungible_token_definition
  "define-non-fungible-token" @context
  (identifier) @name) @item

; Trait definitions and usage
(trait_definition
  "define-trait" @context
  (identifier) @name) @item

(trait_usage
  "use-trait" @context
  (identifier) @name) @item
