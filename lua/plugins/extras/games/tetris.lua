return {
  "alec-gibson/nvim-tetris",
  cmd = "Tetris",
  keys = {
    {
      "<leader>vt",
      "<cmd>Tetris<CR>",
      desc = "Play Tetris",
    },
  },
  config = function()
    local mod = require("nvim-tetris.main")

    local init = mod.init
    mod.init = function()
      init()

      local win = vim.api.nvim_get_current_win()
      local config = vim.api.nvim_win_get_config(win)
      vim.api.nvim_win_set_config(win, { border = "single" })
      vim.wo[win].wrap = true

      local buf = vim.api.nvim_get_current_buf()
      vim.bo[buf].buflisted = false
      vim.keymap.set(
        "n",
        "q",
        "<cmd>close<cr>",
        { buffer = buf, silent = true }
      )
    end
  end,
}
