-- Disable
vim.keymap.set("n", "ZZ", "<nop>")
vim.keymap.set("n", "ZQ", "<nop>")
vim.keymap.set("n", "<c-z>", "<nop>")
vim.keymap.set({ "n", "i", "s" }, "<c-s>", "<nop>")

vim.keymap.set({ "n", "i" }, "<S-Up>", "<nop>")
vim.keymap.set({ "n", "i" }, "<S-Down>", "<nop>")

local nmap = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end
local xmap = function(lhs, rhs, desc)
  vim.keymap.set("x", lhs, rhs, { desc = desc })
end

local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

-- Windows
nmap("<C-w>m", function()
  SereneNvim.toggle.maximize()
end, "Toggle Maximize")
-- vim.keymap.set("n", "]w", "<c-w>w", {})
-- vim.keymap.set("n", "[w", "<c-w>W", {})

-- Buffer
-- vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", {
nmap_leader("bb", "<C-^>", "Switch to Other Buffer")

-- vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", {
--   desc = "Delete Buffer",
-- })
-- vim.keymap.set("n", "<leader>bD", "<cmd>silent! %bd<cr>", {
--   desc = "Delete All Buffers",
-- })
-- vim.keymap.set("n", "<leader>bw", "<cmd>bw<cr>", {
--   desc = "Wipeout Buffer",
-- })
-- vim.keymap.set("n", "<leader>bW", "<cmd>silent! %bw<cr>", {
--   desc = "Wipeout All Buffers",
-- })

-- Resize window using <ctrl> arrow keys
nmap("<c-up>", "<cmd>resize +2<cr>", "Increase window height")
nmap("<c-down>", "<cmd>resize -2<cr>", "Decrease window height")
nmap("<c-left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
nmap("<c-right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Tabs
nmap_leader("<tab>n", "<cmd>tabnew<cr>", "New Tab")
nmap_leader("<tab>d", "<cmd>tabclose<cr>", "Close Tab")
nmap_leader("<tab>l", "<cmd>tablast<cr>", "Last Tab")
nmap_leader("<tab>f", "<cmd>tabfirst<cr>", "First Tab")
nmap_leader("<tab><tab>", "<cmd>tabnext<cr>", "Next Tab")
nmap_leader("<tab><s-tab>", "<cmd>tabprevious<cr>", "Previous Tab")

-- Substitute
nmap_leader("us", [[:%s///gc<left><left><left>]], "Substitute")
xmap_leader("us", [[:s///gc<left><left><left>]], "Substitute Selection")
nmap_leader("ur", [[:cfdo %s///g|update<c-left><right><right><right>]], "Substitute cfdo")

-- Code
vim.keymap.set({ "n", "x" }, "<leader>cs", ":set noexpandtab | retab!<cr>", {
  desc = "Replace tabs with spaces",
})
vim.keymap.set({ "n", "x" }, "<leader>cS", ":set expandtab | retab!<cr>", {
  desc = "Replace spaces with tabs",
})
nmap_leader("ci", "mqHmwgg=G`wzt`q", "Fix indentation")
xmap_leader("ci", "=", "Fix indentation")

-- Extras
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
xmap("J", "omzJ`z")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

vim.keymap.set("t", "<c-x>", [[<c-\><c-n>]], {
  desc = "Go to Normal mode",
})

-- vim.keymap.set(
--   { "n", "x" },
--   "j",
--   [[v:count == 0 ? 'gj' : 'j']],
--   { expr = true }
-- )
-- vim.keymap.set(
--   { "n", "x" },
--   "k",
--   [[v:count == 0 ? 'gk' : 'k']],
--   { expr = true }
-- )
vim.keymap.set("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
  expr = true,
  replace_keycodes = false,
  desc = "Visually select changed text",
})
vim.keymap.set("x", "g/", [[<esc>/\%V]], {
  silent = false,
  desc = "Search inside visual selection",
})
-- vim.keymap.set("x", "?", [[<esc>?\%V]], {
--   desc = "Search Backward within range",
-- })

-- Insert
vim.keymap.set("n", "<leader>ic", function()
  local date = os.date("%y.%m%d.%H%M")
  vim.api.nvim_put({ tostring(date) }, "", true, true)
end, { desc = "Insert custom date" })
vim.keymap.set("n", "<leader>id", function()
  local date = os.date("%Y-%m-%d")
  vim.api.nvim_put({ tostring(date) }, "", true, true)
end, { desc = "Insert date" })
vim.keymap.set("n", "<leader>it", function()
  local date = os.date("%H:%M:%S")
  vim.api.nvim_put({ tostring(date) }, "", true, true)
end, { desc = "Insert time" })

-- Utility
vim.keymap.set("n", "<c-s>", function()
  vim.cmd.write()
  SereneNvim.info("Saved", { id = "sn_save" })
end, { desc = "Save" })

vim.keymap.set("n", "<leader>ud", function()
  vim.diagnostic.reset()
  SereneNvim.info("Reset diagnostics")
end, { desc = "Reset Diagnostics" })

vim.keymap.set("n", "<leader>xq", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { desc = "Toggle Quickfix" })
vim.keymap.set("n", "<leader>xl", function()
  local win = vim.api.nvim_get_current_win()
  local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  local action = qf_winid > 0 and "lclose" or "lopen"
  vim.cmd(action)
end, { desc = "Toggle LocList" })

nmap_leader("ul", "<cmd>Lazy<cr>", "Lazy")

nmap_leader("ui", "<cmd>Inspect<cr>", "Inspect Pos")
nmap_leader("uI", function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input("I")
end, "Inspect Tree")

vim.keymap.set("n", "/", "ms/", {
  desc = "Mark previous before search",
})

vim.keymap.set(
  "n",
  "<leader>uc",
  [[<cmd>%s/\s*\/\*\_.\{-}\*\/\n\|^\s*\/\/.*\n\|\s*\/\/.*//g<cr>]],
  {
    desc = "Delete all comments (js, ts)",
  }
)
vim.keymap.set("x", "<leader>uc", [[:s/\s*\/\*\_.\{-}\*\/\n\|^\s*\/\/.*\n\|\s*\/\/.*//g<cr>]], {
  desc = "Delete all comments (js, ts)",
})
