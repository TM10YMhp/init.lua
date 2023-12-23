return {
  "laytan/cloak.nvim",
  ft = "dotenv",
  keys = {
    { '<leader>uc', '<cmd>CloakToggle<cr>', desc = "Toggle Cloak" }
  },
  opts = {
    enabled = true,
    cloak_character = '*',
    highlight_group = 'Comment',
    patterns = {
      {
        file_pattern = ".env*",
        cloak_pattern = "=.+",
      }
    }
  },
}
