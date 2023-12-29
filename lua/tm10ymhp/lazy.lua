local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = { lazy = true },
  spec = {
    require("plugins.bufferline"),
    require("plugins.cmp"),
    require("plugins.colorscheme"),
    require("plugins.comment"),
    require("plugins.conform"),
    require("plugins.diffview"),
    require("plugins.floaterm"),
    require("plugins.fugitive"),
    require("plugins.gitsigns"),
    require("plugins.harpoon"),
    require("plugins.init"),
    require("plugins.lsp"),
    require("plugins.lualine"),
    require("plugins.mini"),
    require("plugins.nvim_lint"),
    require("plugins.nvim_surround"),
    -- require("plugins.nvim_tree"),
    require("plugins.nvim_ufo"),
    require("plugins.nvim_various_textobjs"),
    require("plugins.telescope"),
    require("plugins.treesitter"),
    require("plugins.trouble"),

    require("plugins.extras.cloak"),
    require("plugins.extras.codeium"),
    require("plugins.extras.dressing"),
    require("plugins.extras.markdown_preview"),
    require("plugins.extras.mini_files"),
    require("plugins.extras.neo_tree"),
    require("plugins.extras.noice"),
    require("plugins.extras.nvim_bqf"),
    require("plugins.extras.nvim_notify"),
    require("plugins.extras.obsidian"),
    require("plugins.extras.project"),
    require("plugins.extras.rest"),
  },
  dev = { path = "~/projects" },
  ui = {
    size = { width = 90, height = 40 },
    wrap = true,
    border = "single",
    icons = {
      cmd = "",
      config = "",
      event = "",
      ft = "",
      init = "",
      import = "",
      keys = "",
      lazy = "(H)",
      loaded = "●",
      not_loaded = "○",
      plugin = "",
      runtime = "",
      require = "",
      source = "",
      start = "",
      task = "",
      list = {
        "●",
        "-",
        "",
        "",
      },
    },
  },
  throttle = 1000,
  checker = {
    enable = false,
  },
  change_detection = {
    enable = false,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "editorconfig",
        "gzip",
        "man",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- autocmds can be loaded lazily when not opening a file
local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
  require('tm10ymhp.autocmds')
end

-- startuptime
vim.api.nvim_create_autocmd("User", {
  once = true,
  pattern = "VeryLazy",
  callback = function()
    if vim.fn.has('clipboard') == 1 then
      vim.opt.clipboard:prepend { "unnamed", "unnamedplus" }
    end

    require('tm10ymhp.diagnostic')

    if lazy_autocmds then
      require('tm10ymhp.autocmds')
    end

    require('tm10ymhp.keymaps')

    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    require("tm10ymhp.utils").notify(
      "lazy.nvim loaded "..stats.loaded.."/"..stats.count.." plugins in "..ms.."ms"
    )
  end
})

-- nvim-lint
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "svelte",
  },
  callback = function()
    vim.defer_fn(function()
      require("lazy").load({
        plugins = { "nvim-lint" },
      })
    end, 1)
  end,
})

-- conform.nvim
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "css",
    "scss",
    "less",
    "html",
    "json",
    "jsonc",
    "yaml",
    "markdown",
    "graphql",
    "handlebars",
    "astro",
  },
  callback = function()
    vim.defer_fn(function()
      require("lazy").load({
        plugins = { "conform.nvim" },
      })
    end, 1)
  end,
})

-- markdown_preview
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "markdown",
  },
  callback = function()
    vim.defer_fn(function()
      require("lazy").load({
        plugins = { "markdown-preview.nvim" },
      })
    end, 1)
  end,
})
