local get_formatter_path = function(filename)
  return vim.fn.expand(vim.fn.stdpath("config") .. "/format/" .. filename)
end

return {
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "biome",
        "blade-formatter",
        "google-java-format",
        "latexindent",
        "php-cs-fixer",
        "prettier",
        "sqlfluff",
        "stylua",
        "typstyle", -- TODO: need pull request
        "goimports",
        "gofumpt",
        "ruff",
        -- need build
        -- "clang-format",
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
        typescript      = { "biome" },
        typescriptreact = { "biome" },

        json            = { "biome" },
        jsonc           = { "biome" },
        css             = { "biome" },
        graphql         = { "biome" },

        cs  = { "csharpier" },
        c   = { "clang-format" },
        cpp = { "clang-format" },

        astro            = { "prettier", lsp_format = "prefer" },
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

        go = { "goimports", "gofumpt", "custom_indent" },

        php = { "php_cs_fixer" },

        lua = { "stylua" },

        tex = { "latexindent" },

        python = { "ruff_format", "ruff_organize_imports" },

        blade = { "blade-formatter" },

        java = { "google-java-format" },

        typst = { "typstyle" },

        ["*"] = { "injected" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },

        custom_indent = {
          format = function(self, ctx, lines, callback)
            local out_lines = {}
            for _, line in ipairs(lines) do
              local trimmed = line:gsub("\t", "  ")
              table.insert(out_lines, trimmed)
            end
            callback(nil, out_lines)
          end,
        },

        ruff_format = {
          append_args = function()
            if not SereneNvim.exists_in_cwd({ "ruff.toml" }) then
              return {
                "--config",
                get_formatter_path("ruff.toml"),
              }
            end
          end,
        },

        typstyle = {
          args = { "--wrap-text" },
        },
        csharpier = {
          command = "csharpier",
          args = { "format", "--write-stdout" },
        },
        php_cs_fixer = {
          args = {
            "fix",
            -- TODO: add php-cs-fixer config
            "--config=" .. get_formatter_path(".php-cs-fixer.php"),
            "$FILENAME",
          },
        },
        prettier = {
          prepend_args = {
            "--html-whitespace-sensitivity=ignore",
          },
        },
        sqlfluff = {
          args = function()
            if not SereneNvim.exists_in_cwd({ ".sqlfluff" }) then
              return {
                "format",
                "--config=" .. get_formatter_path(".sqlfluff"),
                "-",
              }
            end

            return { "format", "-" }
          end,
          require_cwd = false,
        },
        biome = {
          args = {
            "check",
            "--write",
            "--linter-enabled=false",
            "--stdin-file-path",
            "$FILENAME",
          },
          append_args = function()
            if
              not SereneNvim.exists_in_cwd({ "biome.json", "biome.jsonc" })
            then
              return { "--config-path=" .. get_formatter_path("biome.json") }
            end
          end,
        },
        stylua = {
          prepend_args = function()
            if
              not SereneNvim.exists_in_cwd({ ".stylua.toml", "stylua.toml" })
            then
              return {
                "--config-path="
                  .. vim.fn.expand(vim.fn.stdpath("config") .. "/.stylua.toml"),
              }
            end
          end,
        },
        latexindent = {
          prepend_args = {
            "-m",
            "-l="
              .. get_formatter_path("defaultSettings.yaml")
              .. ",localSettings.yaml",
          },
        },
        ["blade-formatter"] = {
          prepend_args = {
            "--indent-size=2",
            "--wrap=80",
            "--indent-inner-html",
            "--extra-liners=''",
          },
        },
      },
    },
  },
}
