local function lazy_init()
  vim.filetype.add({
    extension = {
      env = "dotenv",
    },
    filename = {
      [".env"] = "dotenv",
      ["env"] = "dotenv",
    },
    pattern = {
      -- match filenames like - ".env.example", ".env.local" and so on
      ["%.env%.[%w_.-]+"] = "dotenv",
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("tm10ymhp_dotenv", { clear = true }),
    pattern = { "dotenv" },
    desc = "Set syntax bash for dotenv files",
    callback = function()
      vim.schedule(function()
        vim.opt_local.syntax = "bash"
        vim.opt_local.commentstring = "# %s"
      end)
    end,
  })
end

local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
  lazy_init()
end

vim.api.nvim_create_autocmd("User", {
  once = true,
  pattern = "VeryLazy",
  callback = function()
    if lazy_autocmds then
      lazy_init()
    end
  end,
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
