vim.g.codeium_enabled = true

return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    keys = {
      {
        "<leader>ti",
        function()
          local state = not vim.g.codeium_enabled
          vim.g.codeium_enabled = state

          SereneNvim.info("Codeium " .. (state and "Enabled" or "Disabled"))
        end,
        desc = "Toggle Codeium",
      },
    },
    opts = {
      bin_path = vim.fn.expand("~" .. "/.codeium/bin"),
      config_path = vim.fn.expand("~" .. "/.codeium/config.json"),
    },
    config = function(_, opts)
      require("codeium").setup(opts)
      SereneNvim.hacks.codeium()
    end,
  },
  {
    "nvim-cmp",
    dependencies = { "Exafunction/codeium.nvim" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, 2, {
        name = "codeium",
        group_index = 1,
        priority = 30,
      })
    end,
  },
}
