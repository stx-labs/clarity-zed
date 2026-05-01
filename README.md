# Clarity Language Support for Zed

This repository adds Clarity language support to the Zed editor.
Clarity is a decidable, Lisp-like language used for writing smart contracts on the [Stacks Blockchain](https://github.com/stacks-network/stacks-core)

This plugin adds the following:
- Clarity LSP support (Requires [`clarinet`](https://github.com/hirosystems/clarinet) binary in `$PATH`)
- Tree sitter syntax highlighting using https://github.com/xlittlerag/tree-sitter-clarity

## Configuration

The LSP behavior can be customized by adding the following JSON to Zed's `settings.json` file. This example uses the default values:

```json
"lsp": {
  "clarity-lsp": {
    "enable_lsp_tasks": true,
    "initialization_options": {
      "completion": true,
      "completionSmartParenthesisWrap": true,
      "completionIncludeNativePlaceholders": true,
      "documentSymbols": false,
      "formatting": true,
      "goToDefinition": true,
      "hover": true,
      "signatureHelp": true,
      "staticCostAnalysis": false,
      "debugLogging": false
    }
  }
},
```

## Architecture

This is a minimal Zed extension with two layers:

**Rust WASM extension** (`src/lib.rs`): Implements `zed::Extension` trait. Does two things:
1. `language_server_command`: Locates the `clarinet` binary and runs it with `lsp` arg
2. `language_server_initialization_options`: Passes user LSP settings from Zed's `settings.json` through to the Clarity LSP

**Tree-sitter queries** (`languages/clarity/`):
- `highlights.scm`: Syntax highlighting rules mapping tree-sitter nodes to Zed highlight groups
- `indents.scm`: Auto-indentation rules for `()` and `{}` forms
- `brackets.scm`: Bracket pair definitions for `()`, `{}`, `<>`
- `outline.scm`: Outline/symbol view for all top-level definitions and tuple keys
- `config.toml`: Language metadata: file suffix `.clar`, line comments `;; `

**Extension manifest** (`extension.toml`): Declares the extension ID (`clarity`), language server name, and pins the tree-sitter grammar to a specific commit.

**Grammar** (`grammars/`): Pre-built `clarity.wasm` tree-sitter parser. Sourced from the commit pinned in `extension.toml`. This directory is gitignored — the wasm is built/fetched by Zed at install time.
