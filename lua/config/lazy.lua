local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = { lazy = true },
  spec = {
    { import = "plugins.core" },
    { import = "plugins.vscode" },
    {
      enabled = vim.env.USERNAME == "qwe",
      import = "plugins.personal",
    },
    {
      enabled = vim.env.TERMUX_VERSION ~= nil,
      import = "plugins.phone",
    },
    { import = "plugins" },
  },
  local_spec = false,
  pkg = {
    enabled = false,
    sources = {
      "lazy",
      "rockspec",
      "packspec",
    },
  },
  rocks = {
    -- enabled = false,
    hererocks = false,
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = { path = "~/projects" },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "single",
    -- stylua: ignore
    icons = {
      cmd        = "",
      config     = "",
      event      = "",
      favorite   = "",
      ft         = "",
      init       = "",
      import     = "",
      keys       = "",
      lazy       = "(H) ",
      plugin     = "",
      runtime    = "",
      require    = "",
      source     = "",
      start      = "",
    },
  },
  throttle = 1000,
  diff = { cmd = "diffview.nvim" },
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
        "rplugin",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- startuptime
vim.api.nvim_create_autocmd("User", {
  once = true,
  pattern = "VeryLazy",
  callback = function()
    if vim.fn.has("clipboard") == 1 then
      vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
    end

    require("config.diagnostic")
    require("config.keymaps")

    -- if vim.api.nvim_buf_get_name(0) ~= "" then
    local stats = require("lazy").stats()
    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
    SereneNvim.info(
      "lazy.nvim loaded "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"
    )
    -- end
  end,
})
