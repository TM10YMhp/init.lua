return {
  "nvim-telescope/telescope-symbols.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    { "<leader>is", "<cmd>Telescope symbols<cr>", desc = "Insert Symbol" },
    {
      "<leader>ie",
      "<cmd>lua require'telescope.builtin'.symbols{sources={'emoji'}}<cr>",
      desc = "Insert Emoji",
    },
    {
      "<leader>ik",
      "<cmd>lua require'telescope.builtin'.symbols{sources={'kaomoji'}}<cr>",
      desc = "Insert Kaomoji",
    },
    {
      "<leader>ig",
      "<cmd>lua require'telescope.builtin'.symbols{sources={'gitmoji'}}<cr>",
      desc = "Insert Gitmoji",
    },
  },
}
