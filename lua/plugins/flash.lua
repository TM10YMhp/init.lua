return {
  "folke/flash.nvim",
  -- event = "VeryLazy",
  keys = {
    "/",
    "?",
    "f",
    "F",
    "t",
    "T",
    ";",
    -- ",",
    {
      "<leader>fs",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "<leader>fS",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "<leader>fr",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "<leader>fR",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
  opts = {
    label = {
      current = false,
    },
    highlight = {
      backdrop = false,
    },
    modes = {
      search = {
        enabled = false,
      },
      char = {
        jump_labels = true,
        highlight = {
          backdrop = false,
        },
      },
    },
  },
}