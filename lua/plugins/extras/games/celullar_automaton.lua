return {
  "Eandrju/cellular-automaton.nvim",
  cmd = "CellularAutomaton",
  keys = {
    {
      "<leader>vr",
      "<cmd>CellularAutomaton make_it_rain<CR>",
      desc = "Rain",
    },
    {
      "<leader>vx",
      "<cmd>CellularAutomaton scramble<CR>",
      desc = "Scramble",
    },
    {
      "<leader>vl",
      "<cmd>CellularAutomaton game_of_life<CR>",
      desc = "Game Of Life",
    },
  },
}
