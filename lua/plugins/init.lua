return {
  -- { import = "plugins.presets.vscode" },
  { import = "plugins.presets.personal" },
  -- { import = "plugins.presets.phone" },

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
  -- }

  -- {
  --   "module-serene.nvim",
  --   dir = SereneNvim.get_module_dir("serene.nvim"),
  --   event = "UIEnter",
  --   main = "serene.nvim",
  --   config = function()
  --     -- https://github.com/jackplus-xyz/binary.nvim
  --     require("serene").load()
  --   end,
  -- },

  --

  {
    "easymotion/vim-easymotion",
    init = function() vim.g.EasyMotion_do_shade = 0 end,
    event = "VeryLazy",
  },
}
