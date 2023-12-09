vim.cmd("autocmd!")

local utils = require('tm10ymhp.utils')

local augroup = vim.api.nvim_create_augroup('tm10ymhp', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = "term://*",
  group = augroup,
  desc = 'Config terminal',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*/node_modules/*",
  group = augroup,
  desc = 'Disable diagnostics in node_modules',
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = 'Highlight on yank',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100
    })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "*" },
  callback = function()
    vim.opt.conceallevel = 0
    vim.opt.formatoptions = "qjr"
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = { "*" },
  callback = function()
    if utils.is_large_file(vim.fn.expand('%')) then
      vim.cmd([[syntax clear]])
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.bufhidden = 'unload'
      vim.opt_local.buftype = 'nowrite'
      vim.opt_local.modifiable = false
      vim.opt_local.undolevels = -1
      vim.opt_local.swapfile = false
      vim.opt_local.foldenable = false
      vim.opt_local.filetype = ""
      vim.opt_local.undoreload = 0
      vim.opt_local.list = false
      vim.opt_local.syntax = "OFF"

      vim.opt.eventignore = "CursorMoved,FileType"

      utils.notify("File too long")
    else
      vim.opt.eventignore = ""
    end
  end
})

-- Determine if file is text. This is not 100% proof, but good enough.
-- Source: https://github.com/sharkdp/content_inspector
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = augroup,
--   pattern = { "*" },
--   callback = function()
--     local path = vim.fn.expand('%:p')
--     local fd = vim.loop.fs_open(path, 'r', 1)
--     local is_text = vim.loop.fs_read(fd, 1024):find('\0') == nil
--     vim.loop.fs_close(fd)
--     if not is_text then
--       vim.cmd("lockmarks lua vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'binary file' })")
--       print("binary file")
--     else
--       print("normal file")
--     end
--   end
-- })
