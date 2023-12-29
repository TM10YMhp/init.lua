return {
  "laytan/cloak.nvim",
  ft = "dotenv",
  init = function()
    vim.filetype.add({
      extension = {
        env = "dotenv",
      },
      filename = {
        [".env"] = "dotenv",
        ["env"] = "dotenv",
      },
      pattern = {
        -- INFO: Match filenames like - ".env.example", ".env.local" and so on
        ["%.env%.[%w_.-]+"] = "dotenv",
      },
    })
  end,
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
