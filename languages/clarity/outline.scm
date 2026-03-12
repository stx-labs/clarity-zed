; Outline queries for Clarity
; Patterns matched with @name appear in Zed's symbol outline panel
; and breadcrumb bar, enabling quick navigation via Cmd+Shift+O.

; Tuple field keys in literals and type annotations
(tuple_lit key: (identifier) @name)
(tuple_type key: (identifier) @name)
(tuple_type_for_trait key: (identifier) @name)

; Function definitions
(function_signature (identifier) @name)

; Top-level definitions — constants, variables, maps, tokens, traits
(constant_definition (identifier) @name)
(variable_definition (identifier) @name)
(mapping_definition (identifier) @name)
(fungible_token_definition (identifier) @name)
(non_fungible_token_definition (identifier) @name)
(trait_definition (identifier) @name)
