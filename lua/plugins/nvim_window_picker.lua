return {
  "s1n7ax/nvim-window-picker",
  keys = {
    {
      "<leader>ww",
      function()
        local picked_window_id = require("window-picker").pick_window()
          or vim.api.nvim_get_current_win()

        vim.api.nvim_set_current_win(picked_window_id)
      end,
      desc = "Pick Window",
    },
  },
  opts = {
    hint = "statusline-winbar",
  },
  config = function(_, opts)
    require("window-picker").setup(opts)
  end,
}
