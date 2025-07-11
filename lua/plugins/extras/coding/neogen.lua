return {
  "danymat/neogen",
  cmd = "Neogen",
  keys = {
    {
      "<leader>cc",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations (Neogen)",
    },
  },
  opts = {
    snippet_engine = "luasnip",
  },
}
