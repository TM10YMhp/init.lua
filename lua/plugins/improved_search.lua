return {
  "backdround/improved-search.nvim",
  keys = {
    {
      "!",
      '<cmd>lua require("improved-search").current_word_strict()<cr>',
      desc = "Search Current Word",
    },
    {
      "!",
      '<cmd>lua require("improved-search").in_place()<cr>',
      mode = "x",
      desc = "Search Current Word",
    },
  },
}
