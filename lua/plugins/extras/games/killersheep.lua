return {
  "seandewar/killersheep.nvim",
  cmd = "KillKillKill",
  keys = {
    {
      "<leader>vk",
      "<cmd>KillKillKill<CR>",
      desc = "Play Killer Sheep",
    },
  },
  opts = {
    keymaps = {
      move_left = "<Left>",
      move_right = "<Right>",
      shoot = "s",
    },
  },
}
