return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  commit = "d31323d", -- NOTE: errors in windows after update
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ timeout_ms = 3000 }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                "n",
                true
              )
            end
          end
        end)
      end,
      mode = { "n", "x" },
      desc = "Conform: Format",
    },
    {
      "<leader>tf",
      function()
        SereneNvim.toggle(
          "disable_autoformat",
          { format = "Buffer: Autoformat %s", type = "b", reverse = true }
        )
      end,
      desc = "Buffer: Toggle Format On Save",
    },
    {
      "<leader>tF",
      function()
        SereneNvim.toggle(
          "disable_autoformat",
          { format = "Autoformat %s", type = "g", reverse = true }
        )
      end,
      desc = "Toggle Format On Save",
    },
  },
  opts = {
    default_format_opts = {
      lsp_format = "never",
      async = false,
      quiet = false,
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end

      return { timeout_ms = 500 }
    end,
  },
  config = function(_, opts)
    SereneNvim.hacks.conform()
    require("conform").setup(opts)
  end,
}
