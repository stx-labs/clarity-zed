# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A Zed editor extension that adds Clarity language support. Clarity is a Lisp-like smart contract language for the Stacks blockchain. The extension provides:
- LSP integration via the `clarinet lsp` binary (must be in `$PATH`)
- Tree-sitter syntax highlighting via an external grammar (https://github.com/xlittlerag/tree-sitter-clarity)

## Build Commands

```bash
# Build the extension (compiles to WebAssembly)
cargo build --target wasm32-wasip1

# The wasm32-wasip1 target must be installed first:
rustup target add wasm32-wasip1
```

There are no tests or linting configured in this project.

## Architecture

This is a minimal Zed extension with two layers:

**Rust WASM extension** (`src/lib.rs`): Implements `zed::Extension` trait. Does two things:
1. `language_server_command` — locates the `clarinet` binary and runs it with `lsp` arg
2. `language_server_initialization_options` — passes user LSP settings from Zed's `settings.json` through to the Clarity LSP

**Tree-sitter queries** (`languages/clarity/`):
- `highlights.scm` — syntax highlighting rules mapping tree-sitter nodes to Zed highlight groups
- `indents.scm` — auto-indentation rules for `()` and `{}` forms
- `brackets.scm` — bracket pair definitions for `()`, `{}`, `<>`
- `outline.scm` — outline/symbol view for all top-level definitions and tuple keys
- `config.toml` — language metadata: file suffix `.clar`, line comments `;; `

**Extension manifest** (`extension.toml`): Declares the extension ID (`clarity`), language server name, and pins the tree-sitter grammar to a specific commit.

**Grammar** (`grammars/`): Pre-built `clarity.wasm` tree-sitter parser. Sourced from the commit pinned in `extension.toml`. This directory is gitignored — the wasm is built/fetched by Zed at install time.

## Key Details

- The crate type is `cdylib` — it produces a dynamic library (WASM module), not a binary
- LSP settings are configurable via Zed's `settings.json` under `lsp.clarity-lsp.initialization_options`
- The extension depends on `clarinet` being installed externally; it does not bundle the LSP server
- `extension.wasm` at the repo root is the pre-built extension artifact (also gitignored)

## Editing Tree-sitter Queries

When editing `.scm` files, keep these in mind:
- Available highlight captures are documented at https://zed.dev/docs/extensions/languages#syntax-highlighting
- Zed uses hierarchical capture resolution: `@function.builtin` falls back to `@function` if the theme doesn't style the more specific name
- The node types available for matching come from the tree-sitter-clarity grammar (`grammar.js` in the pinned repo). To see what nodes exist, read that file
- The grammar commit in `extension.toml` must match the grammar the queries are written against — updating the grammar may add/remove/rename nodes
- Clarity language reference: functions at https://docs.stacks.co/reference/clarity/functions, keywords at https://docs.stacks.co/reference/clarity/keywords, types at https://docs.stacks.co/reference/clarity/types
