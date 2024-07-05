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
          lsp_format = "never",
          async = false,
          timeout_ms = 3000,
        })
      end,
      mode = { "n", "x" },
      desc = "Conform: Format",
    },
    {
      "<leader>tf",
      function()
        local state = vim.b.disable_autoformat
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        SereneNvim.info(
          "Buffer: Autoformat " .. (state and "Enabled" or "Disabled")
        )
      end,
      desc = "Buffer: Toggle Format On Save",
    },
    {
      "<leader>tF",
      function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          SereneNvim.info("Autoformat enabled")
        else
          vim.g.disable_autoformat = true
          SereneNvim.info("Autoformat disabled")
        end
      end,
      desc = "Toggle Format On Save",
    },
  },
  opts = {
    formatters = {
      stylua = {
        prepend_args = function()
          local cwd = vim.uv.cwd()
          if
            vim.fn.filereadable(cwd .. "/.stylua.toml")
            or vim.fn.filereadable(cwd .. "/stylua.toml")
          then
            return {}
          end

          return {
            "--config-path=" .. vim.fn.stdpath("config") .. "/.stylua.toml",
          }
        end,
      },
      prettier = {
        prepend_args = function(_, ctx)
          if vim.endswith(ctx.filename, ".astro") then
            return {
              "--plugin=prettier-plugin-astro",
            }
          end
        end,
      },
      ["blade-formatter"] = {
        prepend_args = {
          "--indent-inner-html",
          "--extra-liners=''",
        },
      },
    },
    formatters_by_ft = {
      -- stylua: ignore start
      cs              = { "clang-format" },
      c               = { "clang-format" },
      cpp             = { "clang-format" },
      lua             = { "stylua" },
      json            = { "biome" },
      jsonc           = { "biome" },
      javascript      = { "biome" },
      javascriptreact = { "biome" },
      typescript      = { "biome" },
      typescriptreact = { "biome" },
      vue             = { "prettier" },
      css             = { "prettier" },
      scss            = { "prettier" },
      less            = { "prettier" },
      html            = { "prettier" },
      yaml            = { "prettier" },
      markdown        = { "prettier" },
      graphql         = { "prettier" },
      handlebars      = { "prettier" },
      astro           = { "prettier" },
      java            = { "google-java-format" },
      blade           = { "blade-formatter" },
      php             = { "php_cs_fixer" },
      -- stylua: ignore end
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

      return {
        lsp_format = "never",
        async = false,
        quiet = false,
        timeout_ms = 800,
      }
    end,
  },
}
