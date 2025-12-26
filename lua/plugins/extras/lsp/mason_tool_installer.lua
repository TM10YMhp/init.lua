return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  event = "VeryLazy",
  opts_extend = { "ensure_installed" },
  opts = { ensure_installed = {} },
  config = function(_, opts)
    require("mason-tool-installer").setup(opts)
    require("mason-tool-installer").run_on_start()
  end,
}
