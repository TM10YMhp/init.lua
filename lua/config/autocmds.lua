local augroup = vim.api.nvim_create_augroup("serenenvim", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  group = augroup,
  desc = "Config terminal",
  callback = function()
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
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp" },
  callback = function() vim.opt_local.iskeyword:remove({ "-" }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  desc = "Conceal and format options",
  callback = function()
    vim.opt.conceallevel = 0
    vim.opt.formatoptions = "qjr"
  end,
})

local function augroup_create(name)
  return vim.api.nvim_create_augroup("serenenvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup_create("checktime"),
  desc = "Check if we need to reload the file",
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup_create("resize_splits"),
  desc = "Resize splits if window got resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup_create("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "grug-far",
    "grug-far-history",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns-blame",
    "floggraph",
    "fugitive",
    "fugitiveblame",
    "httpResult",
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

-- or use `:write ++p`
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup_create("auto_create_dir"),
  desc = "Auto create dir",
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
