return {
  "voldikss/vim-floaterm",
  cmd = "FloatermNew",
  keys = {
    {
      "<M-t>s",
      ":FloatermSend<cr>",
      mode = "x",
      desc = "Send command to a job in floaterm",
    },
    {
      '<M-t>"',
      "<cmd>FloatermNew --wintype=split --height=0.35<cr>",
      desc = "Open a split floaterm window",
    },
    {
      "<M-t>%",
      "<cmd>FloatermNew --wintype=vsplit --width=0.40<cr>",
      desc = "Open a vsplit floaterm window",
    },
    {
      "<M-t>C",
      "<cmd>FloatermNew --cwd=<buffer><cr>",
      desc = "Open a floaterm window (cwd)",
    },
    {
      "<M-t>c",
      "<cmd>FloatermNew<cr>",
      desc = "Open a floaterm window",
    },
    {
      "<M-t>p",
      "<cmd>FloatermPrev<cr>",
      desc = "Switch to the previous floaterm instance",
    },
    {
      "<M-t>n",
      "<cmd>FloatermNext<cr>",
      desc = "Switch to the next floaterm instance",
    },
    {
      "<M-t>t",
      "<cmd>FloatermToggle<cr>",
      desc = "Open or hide the floaterm window",
    },
    {
      "<M-t>t",
      [[<c-\><c-n><cmd>FloatermToggle<cr>]],
      mode = "t",
      desc = "Open or hide the floaterm window",
    },
    {
      "<M-t>j",
      [[<c-\><c-n><cmd>FloatermUpdate --wintype=split --height=0.35<cr>]],
      mode = "t",
      desc = "Update a split floaterm window",
    },
    {
      "<M-t>h",
      [[<c-\><c-n><cmd>FloatermUpdate --wintype=vsplit --width=0.40<cr>]],
      mode = "t",
      desc = "Update a vsplit floaterm window",
    },
    {
      "<M-t>&",
      [[<c-\><c-n><cmd>exe 'FloatermKill'|FloatermNext<cr>]],
      mode = "t",
      desc = "Kill the current floaterm instance",
    },
    {
      "<M-t>c",
      [[<c-\><c-n><cmd>FloatermNew<cr>]],
      mode = "t",
      desc = "Open a floaterm window",
    },
    {
      "<M-t>p",
      [[<c-\><c-n><cmd>FloatermPrev<cr>]],
      mode = "t",
      desc = "Switch to the previous floaterm instance",
    },
    {
      "<M-t>n",
      [[<c-\><c-n><cmd>FloatermNext<cr>]],
      mode = "t",
      desc = "Switch to the next floaterm instance",
    },
    {
      "<M-t>q",
      [[<c-\><c-n><cmd>wincmd p<cr>]],
      mode = "t",
      desc = "Switch back to the previous window",
    },
  },
  config = function()
    vim.g.floaterm_width = 0.85
    vim.g.floaterm_height = 0.85
    vim.g.floaterm_autohide = 2
  end,
}
