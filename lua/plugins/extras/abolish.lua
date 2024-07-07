return {
  "tpope/vim-abolish",
  cmd = { "S", "Subvert", "Abolish" },
  dependencies = {
    "markonm/traces.vim",
    config = function()
      vim.g.traces_substitute_preview = 0
      vim.g.traces_abolish_integration = 1
    end,
  },
  keys = {
    { "cr", desc = "Abolish Coercion" },
    {
      "<leader>uS",
      [[:%S///gc<left><left><left><left>]],
      desc = "Abolish Substitute",
    },
    {
      "<leader>uS",
      [[:S///gc<left><left><left><left>]],
      mode = "x",
      desc = "Abolish Substitute Selection",
    },
  },
}
