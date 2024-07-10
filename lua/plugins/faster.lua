return {
  "pteroctopus/faster.nvim",
  event = "BufReadPre",
  opts = {
    behaviours = {
      bigfile = {
        features_disabled = {
          "custom_feature",
          "defer_feature",

          "illuminate",
          "matchparen",
          -- "lsp",
          -- "treesitter",
          "indent_blankline",
          -- "vimopts",
          -- "syntax",
          -- "filetype",
        },
        filesize = SereneNvim.config.bigfile_size,
      },
    },
    features = {
      custom_feature = {
        on = true,
        defer = false,
        disable = function()
          vim.opt_local.cursorline = false
          vim.opt_local.foldenable = false
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.number = false
          vim.opt_local.signcolumn = "no"

          vim.opt_local.swapfile = false
          vim.opt_local.foldmethod = "manual"
          vim.opt_local.undolevels = -1
          vim.opt_local.undoreload = 0
          vim.opt_local.list = false
        end,
      },
      defer_feature = {
        on = true,
        defer = true,
        disable = function()
          vim.opt_local.filetype = "bigfile"
        end,
      },
    },
  },
}
