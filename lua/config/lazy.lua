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
    { import = "plugins" },
    { import = "plugins.extras" },

    { import = "plugins.extras.coding.codeium" },
    { import = "plugins.extras.coding.neogen" },
    { import = "plugins.extras.coding.tgpt" },

    { import = "plugins.extras.editor.telescope" },
    { import = "plugins.extras.editor.telescope_extensions" },

    -- { import = "plugins.extras.experimental.scrollview" },
    { import = "plugins.extras.experimental.trouble" },

    -- { import = "plugins.extras.games" },

    -- { import = "plugins.extras.ui.bufferline" },
    { import = "plugins.extras.ui.colorscheme" },
    { import = "plugins.extras.ui.cokeline" },
    -- { import = "plugins.extras.ui.dashboard" },
    { import = "plugins.extras.ui.dressing" },
    -- { import = "plugins.extras.ui.lualine" },
    -- { import = "plugins.extras.ui.mini_statusline" },
    { import = "plugins.extras.ui.heirline" },
    { import = "plugins.extras.ui.noice" },
    { import = "plugins.extras.ui.nvim_notify" },
    { import = "plugins.extras.ui.treesitter_context" },

    { import = "plugins.extras.util.abolish" },
    { import = "plugins.extras.util.cloak" },
    { import = "plugins.extras.util.coerce" },
    { import = "plugins.extras.util.dadbod" },
    { import = "plugins.extras.util.debugprint" },
    { import = "plugins.extras.util.grug_far" },
    { import = "plugins.extras.util.harpoon" },
    { import = "plugins.extras.util.markdown_preview" },
    { import = "plugins.extras.util.neotab" },
    { import = "plugins.extras.util.obsidian" },
    { import = "plugins.extras.util.pomo" },
    { import = "plugins.extras.util.rest" },
    { import = "plugins.extras.util.startuptime" },
    { import = "plugins.extras.util.ts_error_translator" },
    { import = "plugins.extras.util.tsc" },
    -- { import = "plugins.extras.util.undotree" },
    { import = "plugins.extras.util.which_key" },

    { import = "plugins.extras.lang.astro" },
    { import = "plugins.extras.lang.blade" },
    { import = "plugins.extras.lang.cmake" },
    { import = "plugins.extras.lang.csharp" },
    { import = "plugins.extras.lang.css" },
    { import = "plugins.extras.lang.cssmodules" },
    { import = "plugins.extras.lang.java" },
    { import = "plugins.extras.lang.json" },
    { import = "plugins.extras.lang.latex" },
    { import = "plugins.extras.lang.lua" },
    { import = "plugins.extras.lang.php" },
    { import = "plugins.extras.lang.python" },
    { import = "plugins.extras.lang.sql" },
    { import = "plugins.extras.lang.tailwind" },
    { import = "plugins.extras.lang.typescript" },
    { import = "plugins.extras.lang.vue" },
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
  -- Enable profiling of lazy.nvim. This will add some overhead,
  -- so only enable this when you are debugging lazy.nvim
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
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

    -- https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
    local function paste()
      return {
        vim.fn.split(vim.fn.getreg(""), "\n"),
        vim.fn.getregtype(""),
      }
    end
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },
      paste = {
        ["+"] = paste,
        ["*"] = paste,
      },
    }

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
