return {
  {
    "markonm/traces.vim",
    event = "VeryLazy",
    config = function()
      vim.g.traces_substitute_preview = 1
      vim.g.traces_abolish_integration = 1
    end,
  },
  {
    "tpope/vim-abolish",
    event = "CmdlineEnter :",
    keys = {
      {
        "<leader>uS",
        [[:%S///gc<left><left><left><left>]],
        desc = "Substitute Preserve Case",
      },
      {
        "<leader>uS",
        [[:S///gc<left><left><left><left>]],
        mode = "x",
        desc = "Substitute Selection Preserve Case",
      },
    },
  },
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    opts = {
      highlight_substituted_text = {
        enabled = true,
        timer = 100,
      },
      range = {
        prefix = "s",
        confirm = false,
      },
      exchange = {
        use_esc_to_cancel = true,
      },
    },
    config = function(_, opts)
      require("substitute").setup(opts)

      vim.keymap.set("n", "s", require("substitute").operator, {})
      vim.keymap.set("n", "ss", require("substitute").line, {})
      vim.keymap.set("n", "S", require("substitute").eol, {})
      vim.keymap.set("x", "s", require("substitute").visual, {})

      vim.keymap.set("n", "<leader>z", require("substitute.range").operator, {})
      vim.keymap.set("x", "<leader>z", require("substitute.range").visual, {})
      vim.keymap.set("n", "<leader>zs", require("substitute.range").word, {})
      vim.keymap.set("n", "<leader>Z", function()
        require("substitute.range").operator({ prefix = "S" })
      end, {})

      vim.keymap.set("n", "sx", require("substitute.exchange").operator, {})
      vim.keymap.set("n", "sxx", require("substitute.exchange").line, {})
      vim.keymap.set("x", "X", require("substitute.exchange").visual, {})
      vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, {})
    end,
  },
}
