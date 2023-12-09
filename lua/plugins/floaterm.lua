return {
  "voldikss/vim-floaterm",
  event = "VeryLazy",
  init = function()
    vim.g.floaterm_width = 0.85
    vim.g.floaterm_height = 0.85
    vim.g.floaterm_autohide = 2
  end,
  config = function()
    vim.keymap.set('x', '<leader>ts', ':FloatermSend<cr>', {
      desc = "Send command to a job in floaterm"
    })
    vim.keymap.set('n', '<leader>t"',
      "<cmd>FloatermNew --wintype=split --height=0.35<cr>",
      { desc = "Open a split floaterm window" }
    )
    vim.keymap.set('n', '<leader>tC',
      "<cmd>FloatermNew --cwd=<buffer><cr>",
      { desc = "Open a floaterm window (cwd)" }
    )
    vim.keymap.set('t', '<leader>t&',
      [[<c-\><c-n><cmd>exe 'FloatermKill'|FloatermNext<cr>]],
      { desc = "Kill the current floaterm instance" }
    )

    vim.keymap.set('n', '<leader>tc', '<cmd>FloatermNew<cr>', {
      desc = "Open a floaterm window"
    })
    vim.keymap.set('n', '<leader>tp', '<cmd>FloatermPrev<cr>', {
      desc = "Switch to the previous floaterm instance"
    })
    vim.keymap.set('n', '<leader>tn', '<cmd>FloatermNext<cr>', {
      desc = "Switch to the next floaterm instance"
    })
    vim.keymap.set('n', '<leader>th', '<cmd>FloatermToggle<cr>', {
      desc = "Open or hide the floaterm window"
    })

    vim.keymap.set('t', '<leader>tc', [[<c-\><c-n><cmd>FloatermNew<cr>]], {
      desc = "Open a floaterm window"
    })
    vim.keymap.set('t', '<leader>tp', [[<c-\><c-n><cmd>FloatermPrev<cr>]], {
      desc = "Switch to the previous floaterm instance"
    })
    vim.keymap.set('t', '<leader>tn', [[<c-\><c-n><cmd>FloatermNext<cr>]], {
      desc = "Switch to the next floaterm instance"
    })
    vim.keymap.set('t', '<leader>th', [[<c-\><c-n><cmd>FloatermToggle<cr>]], {
      desc = "Open or hide the floaterm window"
    })
  end
}
