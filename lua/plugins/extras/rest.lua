SereneNvim.on_lazy_init(function()
  vim.filetype.add({
    extension = {
      http = "http",
    },
  })
end)

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    tag = "v1.2.1", -- NOTE: wait until the project is resumed
    opts = {
      result_split_horizontal = true,
      result = {
        show_curl_command = true,
      },
    },
    keys = {
      {
        "<leader>Rr",
        "<cmd>lua require('rest-nvim').run()<cr>",
        desc = "RestNvim Run",
      },
      {
        "<leader>Rl",
        "<cmd>lua require('rest-nvim').last()<cr>",
        desc = "RestNvim Last",
      },
      {
        "<leader>Rp",
        "<cmd>lua require('rest-nvim').run(true)<cr>",
        desc = "RestNvim Preview",
      },
    },
    config = function(_, opts)
      local rest = require("rest-nvim")

      rest.setup(opts)

      -- HACK: only run in http filetype
      local message = table.concat({
        'RestNvim is only available for filetype "http"',
        'Current filetype is "' .. vim.bo.filetype .. '"',
      }, "\n")

      local orig_run = rest.run
      ---@diagnostic disable-next-line: duplicate-set-field
      rest.run = function(...)
        if vim.bo.filetype == "http" then
          return orig_run(...)
        end

        SereneNvim.warn(message)
      end

      local orig_last = rest.last
      ---@diagnostic disable-next-line: duplicate-set-field
      rest.last = function(...)
        if vim.bo.filetype == "http" then
          return orig_last(...)
        end

        SereneNvim.warn(message)
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = {
        "http",
        "html",
        "json",
      },
    },
  },
}
