vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.fillchars = "eob: ,fold: ,foldopen:v,foldsep: ,foldclose:>"
vim.opt.virtualedit = "block"
vim.opt.shortmess:append("IsWcC")
-- vim.opt.shada = "'20,<50,s10,rdiffview:,rterm:,rgitsigns:,r/Temp/"
vim.opt.shada = "'20,<50,s10"

vim.opt.iskeyword = "@,48-57,_,192-255,-"

if vim.fn.has('clipboard') == 1 then
  vim.opt.clipboard:prepend { "unnamed", "unnamedplus" }
end

-- vim.cmd('filetype plugin indent off')
vim.opt.conceallevel = 0

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.compatible = false
vim.opt.diffopt:append("horizontal,foldcolumn:0")
vim.opt.modeline = false

-- vim.opt.wildignore:append({ '**/node_modules/**', '**/.git/**' })
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.list = false
vim.opt.listchars:append({
  eol = '¬',
  nbsp = '+',
  space = ' ',
  trail = '╱',
  tab = '→ ',
  extends = '…',
  precedes = '…'
})

vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.backup = false

vim.opt.lazyredraw = false
vim.opt.undolevels = 100
vim.opt.history = 1000
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100

vim.opt.title = false
vim.opt.laststatus = 2
vim.opt.scrolljump = 5
vim.opt.scrolloff = 8
vim.opt.sidescroll = 0
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.pumheight = 12
vim.opt.pumwidth = 0
vim.opt.cmdheight = 1
vim.opt.rulerformat = [[%l:%c%V|%L]]
vim.opt.ruler = false

-- local status, nvim_ufo = pcall(require, 'nvim-ufo')
-- if not status then
--   require("tm10ymhp.fold")
-- end
vim.opt.foldopen:remove("hor")

vim.opt.complete = "."
vim.opt.completeopt = "menu,menuone,noinsert,noselect"
vim.opt.hidden = true

vim.opt.cindent = false
vim.opt.indentexpr = ""
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.textwidth = 80
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showmatch = false
vim.opt.matchtime = 3
vim.opt.regexpengine = 0
vim.opt.startofline = false
vim.opt.spell = false
vim.opt.signcolumn = "yes"

vim.opt.incsearch = true
vim.opt.inccommand = ""
-- vim.opt.synmaxcol = 150
vim.opt.belloff = "all"
vim.opt.hlsearch = true
vim.opt.cursorline = false
vim.opt.termguicolors = false
vim.opt.background = "dark"

-- vim.cmd('syntax on')
-- vim.fn.matchadd('Pmenu', [[\t]])
