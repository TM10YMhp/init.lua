-- globals
vim.g.mapleader = ","

vim.g.netrw_fastbrowse = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_mousemaps = 0
vim.g.netrw_winsize = 30

vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20
vim.g.loaded_matchparen = 1

vim.g.markdown_recommended_style = 0

-- clean
vim.g.editorconfig = false
vim.g.loaded_man = false
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- options
vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.fillchars = {
  foldopen = "v",
  foldclose = ">",
  fold = " ",
  foldsep = " ",
  eob = " ",
}
vim.opt.virtualedit = "block"
vim.opt.shortmess:append("IsWcC")
vim.opt.shada = "'20,<50,s10"

vim.opt.winminwidth = 5
vim.opt.winheight = 5
vim.opt.winminheight = 5

vim.opt.cursorline = true

vim.opt.iskeyword = "@,48-57,_,192-255,-"

vim.opt.conceallevel = 0

vim.opt.diffopt:append("horizontal,foldcolumn:0")
vim.opt.modeline = false

vim.opt.wildmode = "longest:full,full"

vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.backup = false

vim.opt.undolevels = 100
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
vim.opt.showmode = false
vim.opt.pumheight = 12
vim.opt.pumwidth = 0
vim.opt.rulerformat = [[%l:%c%V|%L]]
vim.opt.ruler = false

vim.opt.foldopen:remove("hor")

vim.opt.complete = "."
vim.opt.completeopt = "menu,menuone,noinsert,noselect"

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.textwidth = 80
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.inccommand = ""

vim.opt.matchtime = 3
