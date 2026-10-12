# 🌀 Neovim Config

A personal Neovim configuration built on [packer.nvim](https://github.com/wbthomason/packer.nvim), with LSP, completion, fuzzy finding, a file tree, and the [Rose Pine](https://github.com/rose-pine/neovim) theme.

## Requirements

- **Neovim 0.12+, stable release.** nvim-treesitter's `main` branch needs 0.12+, and some plugins break on older nightly builds.
- **[tree-sitter CLI](https://github.com/tree-sitter/tree-sitter)** and a C compiler, to build the treesitter parsers.
- **clangd (for C/C++)**: it should come from the same LLVM version as the compiler your projects use. On macOS, the config uses Homebrew LLVM's clangd (`/opt/homebrew/opt/llvm/bin/clangd`) if it's installed; otherwise it uses whichever `clangd` is on `PATH`.

macOS:

```sh
brew install neovim tree-sitter-cli llvm
```

Ubuntu / Debian (the apt `neovim` package is often older than 0.12, so install a release from [GitHub](https://github.com/neovim/neovim/releases) instead):

```sh
sudo apt install build-essential clangd
cargo install --locked tree-sitter-cli   # or: npm install -g tree-sitter-cli
```

## Features

- **LSP** via `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig` (auto-installs servers)
- **Completion** with [blink.cmp](https://github.com/saghen/blink.cmp) and `friendly-snippets`
- **Fuzzy finding** with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **File tree** with [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- **Syntax highlighting** with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Quick file navigation** with [Harpoon](https://github.com/ThePrimeagen/harpoon)
- **Git integration** with [vim-fugitive](https://github.com/tpope/vim-fugitive)
- **Undo history** with [undotree](https://github.com/mbbill/undotree)
- **AI completion** with GitHub Copilot

## Installation

1. Back up any existing config:

   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repo into your config directory:

   ```sh
   git clone <your-repo-url> ~/.config/nvim
   ```

3. Install [packer.nvim](https://github.com/wbthomason/packer.nvim):

   ```sh
   git clone --depth 1 https://github.com/wbthomason/packer.nvim \
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```

4. Open Neovim and sync plugins:

   ```sh
   nvim
   ```

   Then run `:PackerSync` inside Neovim. Restart once it finishes — Mason will
   install the configured LSP servers (`lua_ls`, `pyright`, `bashls`, `html`,
   `ts_ls`, and more) on first launch.

## Structure

```
.
├── init.lua              # entry point — loads the mehdi module
├── lua/mehdi/
│   ├── init.lua          # requires packer / remap / set, sets up nvim-tree
│   ├── packer.lua        # plugin declarations
│   ├── remap.lua         # general keymaps
│   └── set.lua           # editor options
└── after/plugin/         # per-plugin keymaps & setup
    ├── telescope.lua
    ├── harpoon.lua
    ├── undotree.lua
    ├── fugitive.lua
    ├── treesitter.lua
    └── colors.lua
```

## Keybindings

Leader key is `<Space>`.

### General

| Key                | Action                               |
| ------------------ | ------------------------------------ |
| `<leader>ff`       | Format buffer (LSP)                  |
| `<leader>s`        | Save file                            |
| `<leader>x`        | Make current file executable         |
| `<leader>rw`       | Replace word under cursor            |
| `<leader>p`        | Paste over selection without yanking |
| `<leader>y`        | Yank to system clipboard             |
| `<leader>d`        | Delete to void register              |
| `J` / `K` (visual) | Move selected lines down / up        |
| `<C-d>` / `<C-u>`  | Half-page scroll, centered           |

### File tree (nvim-tree)

| Key          | Action     |
| ------------ | ---------- |
| `<leader>eo` | Open tree  |
| `<leader>ec` | Close tree |

### Telescope

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>pf` | Find files        |
| `<C-p>`      | Find git files    |
| `<leader>ps` | Grep for a string |

### Harpoon

| Key                             | Action                  |
| ------------------------------- | ----------------------- |
| `<leader>a`                     | Add file to Harpoon     |
| `<C-e>`                         | Toggle quick menu       |
| `<C-j>`/`<C-k>`/`<C-l>`/`<C-;>` | Jump to marked file 1–4 |

### Git & history

| Key          | Action              |
| ------------ | ------------------- |
| `<leader>gt` | Open Fugitive (Git) |
| `<leader>u`  | Toggle Undotree     |

## License

Released under the [MIT License](LICENSE).
