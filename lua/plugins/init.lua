return {
  -- {
  --   "mason-tool-installer.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     return {
  --       ensure_installed = vim.tbl_filter(
  --         function(x) return not vim.list_contains({ "tinymist", "eslint" }, x) end,
  --         opts.ensure_installed
  --       ),
  --     }
  --   end,
  -- },

  {
    "module-bigfile",
    dir = SereneNvim.get_module_dir("bigfile"),
    -- virtual = true,
    lazy = false,
    main = "bigfile",
    opts = {
      size = SereneNvim.config.bigfile_size,
    },
  },
  {
    "module-injections",
    dir = SereneNvim.get_module_dir("injections"),
    lazy = false,
    main = "injections",
    opts = {},
  },
  {
    "module-fix-auto-scroll",
    dir = SereneNvim.get_module_dir("fix-auto-scroll"),
    event = "BufLeave",
    main = "fix-auto-scroll",
    config = true,
  },

  -- {
  --   "BranimirE/fix-auto-scroll.nvim",
  --   event = "BufLeave",
  --   config = true,
  -- },
}
