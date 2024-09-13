return {
  "ThePrimeagen/vim-be-good",
  cmd = "VimBeGood",
  keys = {
    {
      "<leader>vg",
      "<cmd>VimBeGood<CR>",
      desc = "Play VimBeGood",
    },
  },
  config = function()
    local mod = require("vim-be-good")

    local menu = mod.menu
    mod.menu = function()
      menu()

      local win = vim.api.nvim_get_current_win()
      local config = vim.api.nvim_win_get_config(win)
      vim.api.nvim_win_set_config(win, {
        border = "single",
        height = config.height - 2,
      })
      vim.wo[win].wrap = true

      local buf = vim.api.nvim_get_current_buf()
      vim.bo[buf].filetype = "vim-be-good"
      vim.bo[buf].buflisted = false
      vim.keymap.set(
        "n",
        "q",
        "<cmd>close<cr>",
        { buffer = buf, silent = true }
      )
    end

    local onVimResize = mod.onVimResize
    mod.onVimResize = function()
      onVimResize()

      local win = vim.api.nvim_get_current_win()
      local config = vim.api.nvim_win_get_config(win)
      vim.api.nvim_win_set_config(win, {
        height = config.height - 2,
      })
    end

    vim.api.nvim_create_user_command("VimBeGood", function()
      require("vim-be-good").menu()
    end, {})
  end,
}
