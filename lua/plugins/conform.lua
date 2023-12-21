local utils = require("tm10ymhp.utils")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "css",
    "scss",
    "less",
    "html",
    "json",
    "jsonc",
    "yaml",
    "markdown",
    "graphql",
    "handlebars",
    "astro",
  },
  callback = function()
    vim.defer_fn(function()
      require("lazy").load({
        plugins = { "conform.nvim" },
      })
    end, 1)
  end,
})

return {
  "stevearc/conform.nvim",
  -- event = "BufWritePre",
  cmd = "ConformInfo",
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
      javascript      = { "prettier" },
      javascriptreact = { "prettier" },
      typescript      = { "prettier" },
      typescriptreact = { "prettier" },
      vue             = { "prettier" },
      css             = { "prettier" },
      scss            = { "prettier" },
      less            = { "prettier" },
      html            = { "prettier" },
      json            = { "prettier" },
      jsonc           = { "prettier" },
      yaml            = { "prettier" },
      markdown        = { "prettier" },
      graphql         = { "prettier" },
      handlebars      = { "prettier" },
      astro           = { "prettier" },
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
