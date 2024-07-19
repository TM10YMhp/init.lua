return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
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
    formatters = {
      stylua = {
        prepend_args = function()
          local cwd = vim.uv.cwd()
          if
            vim.fn.filereadable(cwd .. "/.stylua.toml") == 1
            or vim.fn.filereadable(cwd .. "/stylua.toml") == 1
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
    -- stylua: ignore
    formatters_by_ft = {
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
