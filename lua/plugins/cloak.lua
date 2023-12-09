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

    vim.keymap.set('n', '<leader>uC', '<cmd>CloakToggle<cr>', {
      desc = "Toggle Cloak"
    })
  end,
  config = function()
    require("cloak").setup({
      enabled = true,
      cloak_character = '*',
      highlight_group = 'Comment',
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
        }
      }
    })
  end
}
