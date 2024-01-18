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

return {
  "laytan/cloak.nvim",
  ft = "dotenv",
  keys = {
    {
      '<leader>uc',
      function()
        local cloak = require("cloak")
        local utils = require("tm10ymhp.utils")
        if cloak.opts.enabled then
          utils.info("Cloak disabled")
          cloak.disable()
        else
          utils.info("Cloak enabled")
          cloak.enable()
        end
      end,
      desc = "Toggle Cloak",
    }
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
