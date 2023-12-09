-- better up/down
vim.keymap.set(
  { "n", "x" },
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x" },
  "k",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set(
  { "n", "x" },
  "<Up>",
  "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", {
  expr = true, desc = "Next search result"
})
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", {
  expr = true, desc = "Next search result"
})
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", {
  expr = true, desc = "Next search result"
})
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", {
  expr = true, desc = "Prev search result"
})
vim.keymap.set("x", "N", "'nN'[v:searchforward]", {
  expr = true, desc = "Prev search result"
})
vim.keymap.set("o", "N", "'nN'[v:searchforward]", {
  expr = true, desc = "Prev search result"
})

-- Delete Buffer
vim.keymap.set('n', '<leader>qq', '<cmd>bd<cr>', {
  desc = "Delete Buffer"
})
vim.keymap.set('n', '<leader>qa', '<cmd>%bd<cr>', {
  desc = "Delete All Buffers"
})
vim.keymap.set('n', '<leader>qc',
  "<cmd>%bd|e#|bw#<cr>",
  { desc = "Delete All and Reopen" }
)
vim.keymap.set('n', '<leader>qr', '<cmd>e<cr>', {
  desc = "Reopen Buffer"
})

-- Wipeout Buffer
vim.keymap.set('n', '<leader>qQ', '<cmd>bw<cr>', {
  desc = "Wipeout Buffer"
})
vim.keymap.set('n', '<leader>qA', '<cmd>%bw<cr>', {
  desc = "Wipeout All Buffers"
})
vim.keymap.set('n', '<leader>qC',
  "<cmd>let t=expand('%')|%bw|exe 'e '..t|unlet t<cr>",
  { desc = "Wipeout All and Reopen" }
)
vim.keymap.set('n', '<leader>qR',
  "<cmd>let t=expand('%')|bw|exe 'e '..t|unlet t<cr>",
  { desc = "Wipeout and Reopen Buffer" }
)

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<c-up>', '<cmd>resize +2<cr>', {
  desc = "Increase window height"
})
vim.keymap.set('n', '<c-down>', '<cmd>resize -2<cr>', {
  desc = "Decrease window height"
})
vim.keymap.set('n', '<c-left>', '<cmd>vertical resize -2<cr>', {
  desc = "Decrease window width"
})
vim.keymap.set('n', '<c-right>', '<cmd>vertical resize +2<cr>', {
  desc = "Increase window width"
})

-- Utility
vim.keymap.set('n', '<leader>uo', '<cmd>set list!<cr>', {
  desc = "Toggle List Mode"
})
vim.keymap.set('n', '<leader>us', '<cmd>set spell!<cr>', {
  desc = "Toggle Spelling"
})
vim.keymap.set('n', '<leader>uw', '<cmd>set wrap!<cr>', {
  desc = "Toggle Wrap Lines"
})
vim.keymap.set('n', '<leader>un', '<cmd>set number!<cr>', {
  desc = "Toogle Line Numbers"
})
vim.keymap.set('n', '<leader>ul', '<cmd>Lazy<cr>', {
  desc = "Lazy"
})
vim.keymap.set('n', '<leader>um', '<cmd>Mason<cr>', {
  desc = "Mason"
})

-- Buffers
vim.keymap.set('n', '<s-tab>', '<cmd>bp<cr>', {
  desc = "Prev buffer"
})
vim.keymap.set('n', '<tab>', '<cmd>bn<cr>', {
  desc = "Next buffer"
})

-- Tabs
vim.keymap.set('n', '<leader><s-tab>', '<cmd>tabprevious<cr>', {
  desc = "Prev tab"
})
vim.keymap.set('n', '<leader><tab>', '<cmd>tabnext<cr>', {
  desc = "Next tab"
})

-- Substitute
vim.keymap.set('n', [[\\]], [[:%s///gc<left><left><left>]], {
  desc = "Substitute"
})
vim.keymap.set('x', [[\\]], [[:s///gc<left><left><left>]], {
  desc = "Substitute"
})
vim.keymap.set('n', [[\<c-\>]],
  [[:cfdo %s///g|update<c-left><right><right><right>]],
  { desc = "Substitute cfdo" }
)

-- Code
vim.keymap.set({'n', 'x'}, '<leader>cs', ':retab<cr>', {
  desc = "Replace tabs with spaces"
})
vim.keymap.set('n', '<leader>ci', 'mqHmwgg=G`wzt`q', {
  desc = "Fix indentation"
})
vim.keymap.set('x', '<leader>ci', '=', {
  desc = "Fix indentation"
})

-- Disable
vim.keymap.set('n', 'ZZ', '<nop>')
vim.keymap.set('n', 'ZQ', '<nop>')
vim.keymap.set('n', '<c-z>', '<nop>')

-- Extras
vim.keymap.set("x", "J", "omzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set('t', '<leader>tq', [[<c-\><c-n>]], {
  desc = "Go to Normal mode"
})

vim.keymap.set('x', '/', [[<esc>/\%V]], {
  desc = "Search within a range"
})

vim.keymap.set(
  { "o", "x" },
  "ip",
  ":<c-u>norm! `[v`]<cr>",
  { desc = "inner paste textobj" }
)
