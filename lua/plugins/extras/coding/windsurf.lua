return {
  {
    "Exafunction/windsurf.nvim",
    main = "codeium",
    opts = {
      bin_path = vim.fn.stdpath("data") .. ".cache/codeium/bin",
      config_path = vim.fn.stdpath("data") .. ".cache/codeium/config.json",
    },
  },
  {
    "blink.cmp",
    optional = true,
    dependencies = { "windsurf.nvim" },
    opts = {
      keymap = {
        ["<C-s>"] = {
          function(cmp) cmp.show({ providers = { "codeium" } }) end,
        },
      },
      sources = {
        default = { "codeium" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            async = true,
          },
        },
      },
    },
  },
}
