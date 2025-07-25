vim.g.dbs = {
  {
    name = "root@localhost:3306",
    url = "mysql://root@localhost:3306",
  },
}

vim.opt.fileformats = { "unix", "dos" }

-- disable some default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- globals
vim.g.mapleader = ","
vim.g.maplocalleader = "_"

vim.g.markdown_recommended_style = 0

-- options
vim.opt.spelllang = { "en", "es" }
vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.fillchars = {
  foldopen = "v",
  foldclose = ">",
  fold = " ",
  foldsep = " ",
  -- diff = ".",
  diff = " ",
  -- diff = "╱",
  eob = " ",
}
vim.opt.virtualedit = "block"
vim.opt.shortmess:append({ I = true, s = true, W = true, c = true })
vim.opt.shada = { "'20", "<50", "s10" }

vim.opt.winborder = "single"
vim.opt.winminwidth = 5
vim.opt.winheight = 5
vim.opt.winminheight = 5

vim.opt.previewheight = 25

vim.opt.cursorline = true
-- vim.opt.cursorlineopt = "number"

vim.opt.iskeyword:append({ "$", "-" })

vim.opt.conceallevel = 0

vim.opt.diffopt:append({ "context:4", "algorithm:histogram" })
vim.opt.diffopt:append({ "linematch:60" }) -- better diff algorithm: indent

vim.opt.wildmode = { "longest:full", "full" }

vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.backup = false

vim.opt.undolevels = 500
vim.opt.history = 1000
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100

vim.opt.laststatus = 3
vim.opt.scrolljump = 5
vim.opt.scrolloff = 8
vim.opt.sidescroll = 0
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.showcmd = false
vim.opt.showmode = true
vim.opt.pumheight = 12
vim.opt.pumwidth = 0
vim.opt.rulerformat = [[%l:%c%V|%L]]
vim.opt.ruler = false

vim.opt.foldopen:remove("hor")

vim.opt.complete = "."
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

vim.opt.tabstop = 6
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.textwidth = 80
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
-- vim.opt.inccommand = ""

vim.opt.matchtime = 3
