-- ~/.config/nvim/lua/plugins.lua (or packer.lua)
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { { "nvim-lua/plenary.nvim" } },
  }

  -- Theme
  use {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  }

  -- Treesitter (IMPORTANT: see note below about Neovim 0.11 vs 0.12)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    branch = "master",
    -- If you're on Neovim 0.11.x, uncomment the next line to stay compatible:
    -- branch = "master",
  }

  -- REMOVE this: it breaks on modern treesitter (define_modules is gone)
  -- use { "nvim-treesitter/playground" }

  use { "theprimeagen/harpoon" }
  use { "mbbill/undotree" }
  use { "tpope/vim-fugitive" }
  use { "github/copilot.vim" }

  -- blink.cmp (add blink.lib dependency!)
  use {
    "saghen/blink.cmp",
    requires = {
      "saghen/blink.lib",              -- REQUIRED for v2
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = "default" },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },
        signature = { enabled = true },
        fuzzy = { implementation = "lua" },
      })
    end,
  }

  -- Mason must be setup before mason-lspconfig
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  }

  use { "neovim/nvim-lspconfig" }

  use {
    "williamboman/mason-lspconfig.nvim",
    requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    after = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "bashls", "html", "ts_ls", "lua_ls", "pyright" },
        -- mason-lspconfig’s modern role is to auto-enable servers via vim.lsp.enable() [7](https://github.com/mason-org/mason-lspconfig.nvim)
      })

      -- Capabilities from blink (safe even if blink changes; if blink is missing, it won't hard-crash)
      local caps = nil
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        caps = blink.get_lsp_capabilities()
      end

      -- Configure servers using the new Neovim 0.11+ API (no require('lspconfig').setup) [5](https://github.com/neovim/nvim-lspconfig)[6](https://neovimcraft.com/plugin/neovim/nvim-lspconfig/)
      local function cfg(server, conf)
        conf = conf or {}
        if caps then conf.capabilities = caps end
        vim.lsp.config(server, conf)
        vim.lsp.enable(server)
      end

      cfg("lua_ls", {})
      cfg("pyright", {})
      cfg("cssls", {})
      cfg("dockerls", {})
      cfg("docker_compose_language_service", {})
      cfg("clangd", {})
      cfg("vuels", {})
      cfg("ast_grep", {})
      cfg("djlsp", {})

      -- jdtls needs cmd/root markers; keep it explicit
      cfg("jdtls", {
        cmd = { "jdtls" },
        root_markers = { ".git", "pom.xml", "build.gradle" },
      })
    end,
  }

  -- nvim-tree (packer uses "requires", not "dependencies")
  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
  }
end)
