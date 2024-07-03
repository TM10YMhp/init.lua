return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      opts = {
        bin_path = vim.fn.expand("~" .. "/.codeium/bin"),
        config_path = vim.fn.expand("~" .. "/.codeium/config.json"),
      },
    },
  },
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, 2, {
      name = "codeium",
      group_index = 1,
    })
  end,
}
