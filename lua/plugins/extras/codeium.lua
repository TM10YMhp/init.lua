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

      -- HACK: toggle codeium
      vim.g.codeium_enabled = true

      -- https://github.com/Exafunction/codeium.nvim/issues/136
      local Source = require("codeium.source")

      local superclass_is_available = Source.is_available
      ---@diagnostic disable-next-line: duplicate-set-field
      function Source:is_available()
        return superclass_is_available(self) and vim.g.codeium_enabled
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "Exafunction/codeium.nvim" },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, 2, {
        name = "codeium",
        group_index = 1,
      })
    end,
  },
}
