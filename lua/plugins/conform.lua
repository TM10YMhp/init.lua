local utils = require("tm10ymhp.utils")

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  dependencies = { "williamboman/mason.nvim" },
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({
          lsp_fallback = false,
          async = false,
          timeout_ms = 1000
        })
      end,
      mode = { "n", "x" },
      desc = "Conform: Format"
    },
    {
      "<leader>uf",
      function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          utils.notify("Autoformat enabled")
        else
          vim.g.disable_autoformat = true
          utils.notify("Autoformat disabled")
        end
      end,
      desc = "Toggle Format On Save"
    }
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdowm = { "prettier" },
      graphql = { "prettier" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat then
        return
      end

      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end

      return {
        lsp_fallback = false,
        async = false,
        timeout_ms = 1000
      }
    end,
  }
}
