# Neovim configuration

Personal Neovim configuration using Lua and `lazy.nvim`.

## Requirements

- Neovim 0.12 or newer.
- Git (to bootstrap `lazy.nvim`).
- A C compiler and `tree-sitter-cli` for Tree-sitter parser installation.
- `ripgrep` (`rg`) recommended for fast project-wide text searches.
- `fd` recommended for fast file discovery. On Debian/Ubuntu the executable may be named `fdfind`; the configuration detects both names.

Telescope remains loaded early (`VimEnter`, `BufReadPre`, and `BufNewFile`) because it is used as the primary file finder when Neovim starts at a project root. If `fd` is missing, Telescope falls back to `find`. If `rg` is missing, live grep falls back to recursive `grep` and a notification explains how to install ripgrep.

## Screenshot of current theme/config: <br>

<br>
<img src="https://user-images.githubusercontent.com/292349/115295327-7afdce80-a10e-11eb-89b3-2591262bf95a.png"> 
<sub>Image credit: Folke</sub>

## Structure

```text
nvim/
├── init.lua
└── lua/
    ├── config/
    │   ├── icons.lua
    │   ├── keymaps.lua         # All user-defined keymaps and descriptions
    │   ├── lazy.lua
    │   └── options.lua
    └── plugins/
        ├── cmp.lua
        ├── colorscheme.lua
        ├── comment.lua
        ├── conform.lua         # clang-format and stylua formatting
        ├── indent_blankline.lua
        ├── lspconfig.lua
        ├── lsp_signature.lua
        ├── lualine.lua
        ├── mason.lua
        ├── nvim-tree.lua
        ├── telescope.lua
        ├── tmux-nav.lua
        ├── treesitter.lua
```

LSP mappings are installed only in buffers with an attached LSP client. Their definitions remain in `config/keymaps.lua`; `plugins/lspconfig.lua` calls the exported `on_lsp_attach()` function.

## Language servers and formatting

Mason installs and enables `clangd`, `Pyright`, `lua_ls`, and `vimls`. `conform.nvim` provides formatting through `clang-format` for C/C++ and `stylua` for Lua. Mason's tool installer manages those formatter binaries.

## First launch

1. Start Neovim from a project directory.
2. Allow `lazy.nvim` to install plugins. Run `:Lazy sync` and commit the generated `lazy-lock.json` to pin plugin versions.
3. Run `:Mason` to inspect language servers and formatters.
4. Run `:checkhealth` if a dependency or provider is unavailable.
5. Commit `lazy-lock.json` after reviewing the resolved plugin versions.

## Notes

- Tree-sitter uses the `main` branch API: parsers are installed with `require("nvim-treesitter").install()` and highlighting starts through `vim.treesitter.start()` on `FileType`.
- Tree-sitter parser installation requires `tree-sitter-cli` and a compiler.
- Formatting is manual via `<leader>cf`; no automatic format-on-save is enabled.
