return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  dependencies = { "williamboman/mason.nvim" },
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({
          lsp_fallback = false,
          async = false,
          timeout_ms = 3000,
        })
      end,
      mode = { "n", "x" },
      desc = "Conform: Format",
    },
    {
      "<leader>uf",
      function()
        local utils = require("tm10ymhp.utils")
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          utils.info("Autoformat enabled")
        else
          vim.g.disable_autoformat = true
          utils.info("Autoformat disabled")
        end
      end,
      desc = "Toggle Format On Save",
    },
  },
  opts = {
    formatters = {
      stylua = {
        prepend_args = {
          "--config-path=" .. vim.fn.stdpath("config") .. "/.stylua.toml",
        },
      },
    },
    -- stylua: ignore
    formatters_by_ft = {
      lua             = { "stylua" },
      javascript      = { "biome" },
      javascriptreact = { "biome" },
      typescript      = { "biome" },
      typescriptreact = { "biome" },
      vue             = { "prettier" },
      css             = { "prettier" },
      scss            = { "prettier" },
      less            = { "prettier" },
      html            = { "prettier" },
      json            = { "biome" },
      jsonc           = { "biome" },
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
        quiet = false,
        timeout_ms = 1000,
      }
    end,
  },
}
