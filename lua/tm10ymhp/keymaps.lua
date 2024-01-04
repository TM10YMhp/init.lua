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

-- Windows
vim.keymap.set('n', '<leader>wd',
  "<c-w>c",
  { desc = "Delete window" }
)
vim.keymap.set('n', '<leader>wo',
  "<c-w>o",
  { desc = "Delete other windows" }
)
vim.keymap.set('n', '<leader>ws',
  "<c-w>s",
  { desc = "Split window below" }
)
vim.keymap.set('n', '<leader>wv',
  "<c-w>v",
  { desc = "Split window right" }
)
vim.keymap.set('n', '<leader>wp',
  "<c-w>p",
  { desc = "Switch to the previous window" }
)

-- Buffer
vim.keymap.set('n', '<leader>bb',
  "<cmd>e #<cr>",
  { desc = "Switch to Other Buffer" }
)

vim.keymap.set('n', '<leader>qq', '<cmd>bd<cr>', {
  desc = "Delete Buffer"
})
vim.keymap.set('n', '<leader>qa', '<cmd>silent! %bd<cr>', {
  desc = "Delete All Buffers"
})
vim.keymap.set('n', '<leader>qQ', '<cmd>bw<cr>', {
  desc = "Wipeout Buffer"
})
vim.keymap.set('n', '<leader>qA', '<cmd>silent! %bw<cr>', {
  desc = "Wipeout All Buffers"
})

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
vim.keymap.set('n', '<leader>uN', '<cmd>set number!<cr>', {
  desc = "Toogle Line Numbers"
})
vim.keymap.set("n", "<leader>uH", "<cmd>set termguicolors!<cr>", {
  desc = "Toggle Termguicolors"
})
vim.keymap.set("n", "<leader>uD", vim.diagnostic.reset, {
  desc = "Reset Diagnostics"
})
vim.keymap.set('n', '<leader>ul', '<cmd>Lazy<cr>', {
  desc = "Lazy"
})
vim.keymap.set('n', '<leader>um', '<cmd>Mason<cr>', {
  desc = "Mason"
})
vim.keymap.set('n', '<leader>ui', vim.show_pos, {
  desc = "Inspect pos"
})

-- Buffers
vim.keymap.set('n', '<s-tab>', '<cmd>bp<cr>', {
  desc = "Prev buffer"
})
vim.keymap.set('n', '<tab>', '<cmd>bn<cr>', {
  desc = "Next buffer"
})

-- Tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

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

vim.keymap.set('t', '<c-x>', [[<c-\><c-n>]], {
  desc = "Go to Normal mode"
})

vim.keymap.set('x', '/', [[<esc>/\%V]], {
  desc = "Search within a range"
})

vim.keymap.set(
  { "o", "x" },
  "ip",
  ":<c-u>norm! `[v`]<cr>",
  {
    desc = "inner paste textobj",
    silent = true
  }
)

-- Insert
vim.keymap.set(
  "n",
  "<leader>ic",
  function()
    local date = os.date("%y.%m%d.%H%M")
    vim.api.nvim_put({ date }, "", true, true)
  end,
  { desc = "Insert custom date" }
)
vim.keymap.set(
  "n",
  "<leader>id",
  function()
    local date = os.date("%Y-%m-%d")
    vim.api.nvim_put({ date }, "", true, true)
  end,
  { desc = "Insert date" }
)
vim.keymap.set(
  "n",
  "<leader>it",
  function()
    local date = os.date("%H:%M:%S")
    vim.api.nvim_put({ date }, "", true, true)
  end,
  { desc = "Insert time" }
)
