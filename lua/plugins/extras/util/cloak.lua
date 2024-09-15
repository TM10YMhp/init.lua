SereneNvim.on_lazy_init(function()
  vim.filetype.add({
    pattern = {
      -- match filenames like - ".env.example", ".env.local" and so on
      ["%.env%.[%w_.-]+"] = "sh",
    },
  })
end)

return {
  "laytan/cloak.nvim",
  ft = { "sh", "TelescopePrompt" },
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
