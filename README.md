# 🌀 Neovim Config

A personal Neovim configuration built on [packer.nvim](https://github.com/wbthomason/packer.nvim), with LSP, completion, fuzzy finding, a file tree, and the [Rose Pine](https://github.com/rose-pine/neovim) theme.

> Requires **Neovim 0.11+** (uses the modern `vim.lsp.config` / `vim.lsp.enable` API).

## ✨ Features

- **LSP** via `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig` (auto-installs servers)
- **Completion** with [blink.cmp](https://github.com/saghen/blink.cmp) and `friendly-snippets`
- **Fuzzy finding** with [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- **File tree** with [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- **Syntax highlighting** with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **Quick file navigation** with [Harpoon](https://github.com/ThePrimeagen/harpoon)
- **Git integration** with [vim-fugitive](https://github.com/tpope/vim-fugitive)
- **Undo history** with [undotree](https://github.com/mbbill/undotree)
- **AI completion** with GitHub Copilot

## 📦 Installation

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

## 🗂 Structure

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

## ⌨️ Keybindings

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

## 📝 License

Free to use and adapt.
