return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "clang-format",
        "prettier",
        "sqlfluff",
        "php-cs-fixer",
        "stylua",
        "latexindent",
        "ruff",
        "blade-formatter",
        "google-java-format",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        biome = function()
          return true
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- stylua: ignore
      formatters_by_ft = {
        javascript      = { "biome" },
        javascriptreact = { "biome" },
        json            = { "biome" },
        jsonc           = { "biome" },
        typescript      = { "biome" },
        typescriptreact = { "biome" },

        cs  = { "clang-format" },
        c   = { "clang-format" },
        cpp = { "clang-format" },

        astro            = { "prettier", lsp_format = "prefer" },
        css              = { "prettier" },
        graphql          = { "prettier" },
        handlebars       = { "prettier" },
        html             = { "prettier" },
        less             = { "prettier" },
        markdown         = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        scss             = { "prettier" },
        vue              = { "prettier" },
        yaml             = { "prettier" },

        sql   = { "sqlfluff" },
        mysql = { "sqlfluff" },
        plsql = { "sqlfluff" },

        php = { "php_cs_fixer" },

        lua = { "stylua" },

        tex = { "latexindent" },

        python = { "ruff_format" },

        blade = { "blade-formatter" },

        java = { "google-java-format" },
      },
      formatters = {
        prettier = {
          prepend_args = {
            "--html-whitespace-sensitivity=ignore",
          },
        },
        sqlfluff = {
          args = { "format", "--dialect=ansi", "-" },
        },
        stylua = {
          prepend_args = function()
            if
              not SereneNvim.exists_in_cwd({
                ".stylua.toml",
                "stylua.toml",
              })
            then
              return {
                "--config-path=" .. vim.fn.stdpath("config") .. "/.stylua.toml",
              }
            end
          end,
        },
        latexindent = {
          append_args = { "-m", "-l" },
        },
        ["blade-formatter"] = {
          prepend_args = {
            "--indent-inner-html",
            "--extra-liners=''",
          },
        },
      },
    },
  },
}
