require("mehdi.packer")
require("mehdi.remap")
require("mehdi.set")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--pcall optionally enable 24-bit colour
vim.opt.termguicolors = true

require("nvim-tree").setup({
    hijack_directories = {
        enable = true,
    },
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                file = false,
                folder = true,
                folder_arrow = true,
                git = false,
            },
            glyphs = {
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "📁",
                    open = "📂",
                    empty = "📁",
                    empty_open = "📁",
                    symlink = "📁",
                    symlink_open = "📁",
                },
            },
        },
    },
})
-- Global fillchars setting
vim.opt.fillchars = { eob = " " }

-- Ensure it persists for nvim-tree specifically
vim.api.nvim_create_autocmd({"FileType", "BufEnter", "BufWinEnter"}, {
  pattern = {"NvimTree", "NvimTree_*"},
  callback = function()
    vim.cmd('highlight NvimTreeNormal guibg=#1e1e2e')
    vim.cmd('highlight NvimTreeEndOfBuffer guibg=#1e1e2e')
    vim.opt_local.fillchars = { eob = " " }
  end,
})
