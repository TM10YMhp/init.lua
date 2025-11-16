return {
  "pechorin/any-jump.vim",
  cmd = { "AnyJump", "AnyJumpArg", "AnyJumpLastResults" },
  keys = {
    { "<leader>jj", "<cmd>AnyJump<cr>", desc = "AnyJump" },
    { "<leader>ja", ":AnyJumpArg ", desc = "AnyJumpArg" },
    {
      "<leader>jr",
      "<cmd>AnyJumpLastResults<cr>",
      desc = "AnyJumpLastResults",
    },
  },
  init = function() vim.g.any_jump_disable_default_keybindings = 1 end,
  config = function()
    vim.g.any_jump_grouping_enabled = 1
    vim.g.any_jump_preview_lines_count = 2

    vim.g.any_jump_window_width_ratio = 0.8
    vim.g.any_jump_window_height_ratio = 0.8
  end,
}
