return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>tf",
        function() Snacks.terminal(nil, { win = { position = "float" } }) end,
        desc = "Terminal Float",
      },
      {
        "<C-\\>",
        function() Snacks.terminal() end,
        desc = "Toggle Terminal",
      },
      { "<M-t>q", [[<c-\><c-n><cmd>wincmd p<cr>]], mode = "t" },
    },
    opts = {
      terminal = {
        shell = "cmd /s /k clink inject",
      },
    },
  },
}
