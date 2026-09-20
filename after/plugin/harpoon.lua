local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- Neovim 0.13 removed the BufModifiedSet autocmd event (|OptionSet| with the
-- pattern "modified" replaces it). harpoon v1 is unmaintained and still runs
--
--     autocmd BufModifiedSet <buffer=N> set nomodified
--
-- at the end of toggle_quick_menu(), which now throws E216 and aborts the
-- function before it registers the BufLeave autocmd that closes the menu.
--
-- Swallow just that one :autocmd while the menu opens, then re-create it with
-- the supported event. On Neovim < 0.13 this wrapper does nothing.
local has_buf_modified_set = vim.fn.exists('##BufModifiedSet') == 1

local function keep_menu_unmodified(bufnr)
  local group = vim.api.nvim_create_augroup('HarpoonMenuNoModified', { clear = true })
  vim.api.nvim_create_autocmd('OptionSet', {
    group = group,
    pattern = 'modified',
    desc = 'Keep the harpoon quick menu buffer marked unmodified',
    callback = function()
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return true -- menu is gone: delete this autocmd
      end
      if vim.bo[bufnr].modified then
        vim.bo[bufnr].modified = false
      end
    end,
  })
end

local function toggle_quick_menu()
  if has_buf_modified_set then
    return ui.toggle_quick_menu()
  end

  local real_cmd = vim.cmd
  vim.cmd = setmetatable({}, {
    __index = real_cmd,
    __newindex = function(_, key, value) real_cmd[key] = value end,
    __call = function(_, cmd, ...)
      if type(cmd) == 'string' and cmd:match('^%s*autocmd%s+BufModifiedSet') then
        return
      end
      return real_cmd(cmd, ...)
    end,
  })

  local ok, err = pcall(ui.toggle_quick_menu)
  vim.cmd = real_cmd

  if not ok then
    error(err, 0)
  end

  if Harpoon_bufh then
    keep_menu_unmodified(Harpoon_bufh)
  end
end

vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', toggle_quick_menu)

vim.keymap.set('n', '<C-h>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-j>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-k>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-l>', function() ui.nav_file(4) end)
