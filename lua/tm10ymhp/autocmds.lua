local utils = require("tm10ymhp.utils")

local augroup = vim.api.nvim_create_augroup("tm10ymhp", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  group = augroup,
  desc = "Config terminal",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.cursorline = false
    vim.opt_local.scrolloff = 0
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
      -- on_visual = false,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "*" },
  desc = "Conceal and format options",
  callback = function()
    vim.opt.conceallevel = 0
    vim.opt.formatoptions = "qjr"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "qf" },
  desc = "Open qf in vertical split",
  command = "wincmd J",
})

local function augroup_create(name)
  return vim.api.nvim_create_augroup("tm10ymhp_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup_create("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "floggraph",
    "fugitive",
    "fugitiveblame",
  },
  desc = "Close with q",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup_create("auto_create_dir"),
  desc = "Auto create dir",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
