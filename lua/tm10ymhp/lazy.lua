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
    require("plugins.bufferline"),
    require("plugins.cmp"),
    require("plugins.colorscheme"),
    require("plugins.diffview"),
    require("plugins.faster"),
    require("plugins.floaterm"),
    require("plugins.fugitive"),
    require("plugins.gitsigns"),
    require("plugins.harpoon"),
    require("plugins.heirline"),
    require("plugins.init"),
    require("plugins.lazydev"),
    require("plugins.lsp"),
    require("plugins.lualine"),

    require("plugins.mini"),
    -- mini
    -- require("plugins.mini.mini_ai"),
    -- require("plugins.mini.mini_align"),
    -- require("plugins.mini.mini_bracketed"),
    -- require("plugins.mini.mini_bufremove"),
    -- require("plugins.mini.mini_jump2d"),
    -- require("plugins.mini.mini_move"),
    -- require("plugins.mini.mini_trailspace"),

    require("plugins.neo_tree"),
    require("plugins.nvim_early_retirement"),
    require("plugins.nvim_surround"),
    require("plugins.nvim_ufo"),
    require("plugins.nvim_various_textobjs"),
    require("plugins.nvim_window_picker"),
    require("plugins.project"),
    require("plugins.statuscol"),
    require("plugins.telescope"),
    require("plugins.treesitter"),
    require("plugins.ts_comments"),

    require("plugins.extras.abolish"),
    require("plugins.extras.cloak"),
    require("plugins.extras.codeium"),
    require("plugins.extras.conform"),
    -- require("plugins.extras.dadbod"),
    require("plugins.extras.dashboard"),
    require("plugins.extras.debugprint"),
    require("plugins.extras.dressing"),
    require("plugins.extras.git_messenger"),
    require("plugins.extras.markdown_preview"),
    require("plugins.extras.nvim_bqf"),
    require("plugins.extras.nvim_jdtls"),
    require("plugins.extras.nvim_lint"),
    require("plugins.extras.nvim_notify"),
    require("plugins.extras.obsidian"),
    require("plugins.extras.oil"),
    require("plugins.extras.pomo"),
    require("plugins.extras.rest"),
    require("plugins.extras.todo_comments"),
    require("plugins.extras.ts_error_translator"),
    require("plugins.extras.tsc"),
    require("plugins.extras.which_key"),
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
    icons = {
      -- stylua: ignore start
      cmd        = "",
      config     = "",
      event      = "",
      favorite   = "",
      ft         = "",
      init       = "",
      import     = "",
      keys       = "",
      lazy       = "(H) ",
      loaded     = "●",
      not_loaded = "○",
      plugin     = "",
      runtime    = "",
      require    = "",
      source     = "",
      start      = "",
      task       = "",
      list       = {
        "●",
        "-",
        "*",
        "-",
      },
      -- stylua: ignore end
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

-- autocmds can be loaded lazily when not opening a file
local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
  require("tm10ymhp.autocmds")
end

-- startuptime
vim.api.nvim_create_autocmd("User", {
  once = true,
  pattern = "VeryLazy",
  callback = function()
    if vim.fn.has("clipboard") == 1 then
      vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
    end

    require("tm10ymhp.diagnostic")

    if lazy_autocmds then
      require("tm10ymhp.autocmds")
    end

    require("tm10ymhp.keymaps")

    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= "" then
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
