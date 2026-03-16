# CLAUDE.md

See `README.md` for additional context

## Key Details

- The crate type is `cdylib` — it produces a dynamic library (WASM module), not a binary
- LSP settings are configurable via Zed's `settings.json` under `lsp.clarity-lsp.initialization_options`
- The extension depends on `clarinet` being installed externally; it does not bundle the LSP server
- `extension.wasm` at the repo root is the pre-built extension artifact (also gitignored)

## Documentation Links

- Zed
  - Details on language extension development and syntax highlighting are at https://zed.dev/docs/extensions/languages
- Clarity
  - Functions: https://docs.stacks.co/reference/clarity/functions
  - Keywords: https://docs.stacks.co/reference/clarity/keywords
  - Types: https://docs.stacks.co/reference/clarity/types

## Editing Tree-sitter Queries

When editing `.scm` files, keep these in mind:
- Available highlight captures are documented at #syntax-highlighting
- Zed uses hierarchical capture resolution: `@function.builtin` falls back to `@function` if the theme doesn't style the more specific name
- The node types available for matching come from the tree-sitter-clarity grammar (`grammar.js` in the pinned repo). To see what nodes exist, read that file
- The grammar commit in `extension.toml` must match the grammar the queries are written against — updating the grammar may add/remove/rename nodes

