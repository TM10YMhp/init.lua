return {
  "folke/ts-comments.nvim",
  keys = {
    {
      "gc",
      function()
        return require("vim._comment").operator()
      end,
      expr = true,
      mode = { "n", "x" },
      desc = "Toggle comment",
    },
    {
      "gcc",
      function()
        return require("vim._comment").operator() .. "_"
      end,
      expr = true,
      desc = "Toggle comment line",
    },
    {
      "gc",
      function()
        require("vim._comment").textobject()
      end,
      mode = { "o" },
      desc = "Comment textobject",
    },
  },
  opts = {},
}
