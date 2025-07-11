return {
  "rhysd/git-messenger.vim",
  cmd = "GitMessenger",
  keys = {
    { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "Git Messenger" },
  },
  config = function()
    vim.g.git_messenger_floating_win_opts = {
      border = "single",
      row = 1,
      col = 1,
      style = "minimal",
      relative = "cursor",
    }
    vim.g.git_messenger_popup_content_margins = false
    vim.g.git_messenger_no_default_mappings = true
    vim.g.git_messenger_include_diff = "current"
    vim.g.git_messenger_max_popup_width = 80
    vim.g.git_messenger_max_popup_height = 40
  end,
}
