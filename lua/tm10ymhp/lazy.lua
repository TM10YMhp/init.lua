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
    { import = "plugins" },
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
