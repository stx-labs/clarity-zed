; Indentation queries for Clarity
; @indent must be on a parent node (not the delimiter itself). The wildcard
; _ matches any node containing the given delimiters. Follows the same
; pattern used by Clojure/Scheme/Racket extensions in Zed.

; Parenthesized forms — function calls, definitions, let bindings, etc.
(_ "(" ")" @end) @indent

; Tuple literals and tuple type annotations
(_ "{" "}" @end) @indent
