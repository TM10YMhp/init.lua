return {
  "echasnovski/mini.move",
  keys = {
    { "<M-k>", desc = "Move line up" },
    { "<M-j>", desc = "Move line down" },
    { "<M-h>", desc = "Move line left" },
    { "<M-l>", desc = "Move line right" },

    { "<M-k>", mode = "x", desc = "Move up" },
    { "<M-j>", mode = "x", desc = "Move down" },
    { "<M-h>", mode = "x", desc = "Move left" },
    { "<M-l>", mode = "x", desc = "Move right" },

    {
      "<M-left>",
      [[<Cmd>lua MiniMove.move_line('left')<CR>]],
      desc = "Move line left",
    },
    {
      "<M-right>",
      [[<Cmd>lua MiniMove.move_line('right')<CR>]],
      desc = "Move line right",
    },
    {
      "<M-down>",
      [[<Cmd>lua MiniMove.move_line('down')<CR>]],
      desc = "Move line down",
    },
    {
      "<M-up>",
      [[<Cmd>lua MiniMove.move_line('up')<CR>]],
      desc = "Move line up",
    },

    {
      "<M-left>",
      [[<Cmd>lua MiniMove.move_selection('left')<CR>]],
      mode = "x",
      desc = "Move left",
    },
    {
      "<M-right>",
      [[<Cmd>lua MiniMove.move_selection('right')<CR>]],
      mode = "x",
      desc = "Move right",
    },
    {
      "<M-down>",
      [[<Cmd>lua MiniMove.move_selection('down')<CR>]],
      mode = "x",
      desc = "Move down",
    },
    {
      "<M-up>",
      [[<Cmd>lua MiniMove.move_selection('up')<CR>]],
      mode = "x",
      desc = "Move up",
    },
  },
  config = true,
}
