return {
  "voldikss/vim-floaterm",
  init = function()
    vim.g.floaterm_width = 0.85
    vim.g.floaterm_height = 0.85
    vim.g.floaterm_autohide = 2
  end,
  cmd = "FloatermNew",
  keys = {
    {
      '<leader>tj',
      [[<c-\><c-n><cmd>FloatermUpdate --wintype=split --height=0.35<cr>]],
      mode = 't',
      desc = "Update a split floaterm window"
    },
    {
      '<leader>th',
      [[<c-\><c-n><cmd>FloatermUpdate --wintype=vsplit --width=0.40<cr>]],
      mode = 't',
      desc = "Update a vsplit floaterm window"
    },
    {
      '<leader>ts',
      ':FloatermSend<cr>',
      mode = 'x',
      desc = "Send command to a job in floaterm"
    },
    {
      '<leader>t"',
      "<cmd>FloatermNew --wintype=split --height=0.35<cr>",
      desc = "Open a split floaterm window"
    },
    {
      '<leader>t%',
      "<cmd>FloatermNew --wintype=vsplit --width=0.40<cr>",
      desc = "Open a vsplit floaterm window"
    },
    {
      '<leader>tC',
      "<cmd>FloatermNew --cwd=<buffer><cr>",
      desc = "Open a floaterm window (cwd)"
    },
    {
      '<leader>t&',
      [[<c-\><c-n><cmd>exe 'FloatermKill'|FloatermNext<cr>]],
      mode = 't',
      desc = "Kill the current floaterm instance"
    },
    {
      '<leader>tc',
      '<cmd>FloatermNew<cr>',
      desc = "Open a floaterm window"
    },
    {
      '<leader>tp',
      '<cmd>FloatermPrev<cr>',
      desc = "Switch to the previous floaterm instance"
    },
    {
      '<leader>tn',
      '<cmd>FloatermNext<cr>',
      desc = "Switch to the next floaterm instance"
    },
    {
      '<leader>tt',
      '<cmd>FloatermToggle<cr>',
      desc = "Open or hide the floaterm window"
    },

    {
      '<leader>tc',
      [[<c-\><c-n><cmd>FloatermNew<cr>]],
      mode = 't',
      desc = "Open a floaterm window"
    },
    {
      '<leader>tp',
      [[<c-\><c-n><cmd>FloatermPrev<cr>]],
      mode = 't',
      desc = "Switch to the previous floaterm instance"
    },
    {
      '<leader>tn',
      [[<c-\><c-n><cmd>FloatermNext<cr>]],
      mode = 't',
      desc = "Switch to the next floaterm instance"
    },
    {
      '<leader>tt',
      [[<c-\><c-n><cmd>FloatermToggle<cr>]],
      mode = 't',
      desc = "Open or hide the floaterm window"
    },
  },
}
