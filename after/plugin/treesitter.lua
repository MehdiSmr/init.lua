-- nvim-treesitter `main` branch (Neovim 0.12+).
-- The plugin now only installs parsers/queries; highlighting is Neovim's own
-- vim.treesitter.start(), enabled per buffer below.
local ts = require("nvim-treesitter")

-- Parsers that must always be installed (no-op if already present; runs async)
ts.install({
  "javascript", "typescript", "c", "cpp", "cmake", "rust", "lua",
  "vim", "vimdoc", "query", "markdown", "markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("mehdi_treesitter", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    -- Parser already installed: start highlighting
    if pcall(vim.treesitter.start, args.buf, lang) then
      return
    end

    -- Replaces the old `auto_install = true`: install the missing parser,
    -- then start highlighting once it's ready
    if vim.tbl_contains(ts.get_available(), lang) then
      ts.install(lang):await(function()
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end)
      end)
    end
  end,
})
