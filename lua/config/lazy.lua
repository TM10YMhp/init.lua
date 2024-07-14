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
    { import = "plugins" },
    { import = "plugins.extras" },
  },
  pkg = {
    sources = {
      -- "lazy", -- HACK: disable lazy.lua, SereneNvim will manage it
      "rockspec", -- will only be used when rocks.enabled is true
      "packspec",
    },
  },
  rocks = {
    -- TODO: check updated docs, this feature not documented
    hererocks = false,
  },
  dev = { path = "~/projects" },
  ui = {
    size = { width = 90, height = 40 },
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
  checker = { enable = false },
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

SereneNvim.on_lazy_init(function()
  require("config.autocmds")
end)

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

    if vim.api.nvim_buf_get_name(0) ~= "" then
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
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  callback = function()
    -- This is a modification of mini.completion
    -- Only displays signature information
    require("tm10ymhp.mini_signature").setup({
      window = {
        signature = { border = "single" },
      },
    })
  end,
})
