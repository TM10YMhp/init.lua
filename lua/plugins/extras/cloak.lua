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
  ft = { "dotenv", "TelescopePrompt" },
  keys = {
    {
      "<leader>tc",
      function()
        local cloak = require("cloak")
        if cloak.opts.enabled then
          SereneNvim.info("Cloak Disabled")
          cloak.disable()
        else
          SereneNvim.info("Cloak Enabled")
          cloak.enable()
        end
      end,
      desc = "Toggle Cloak",
    },
  },
  opts = {
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    patterns = {
      {
        file_pattern = ".env*",
        cloak_pattern = "=.+",
      },
    },
  },
}
