return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- only detect tailwind config files
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.mjs",
              "tailwind.config.ts"
            )(fname)
          end,
          settings = {
            tailwindCSS = {
              hovers = true,
              suggestions = true,
              emmetCompletions = false,
              colorDecorators = false,
              codeActions = false,
              classAttributes = {
                "class",
                "className",
                "ngClass",
                "classNames",
              },
              experimental = {
                classRegex = {
                  {
                    "(?:cva|cx|twMerge|cn)\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
                    -- "\"(.*?)\""
                    '"(.*?)"',
                  },
                  -- "\"([^\"]*)\""
                  { "[cC]lassName[s]?\\s*=\\s*{([^}]+)}", '"([^"]*)"' },
                  { "@apply\\s([^;\\n]*)" },
                },
              },
            },
          },
        },
      },
    },
  },
  -- TODO: check this
  -- {
  --   "williamboman/mason.nvim",
  --   opts = { ensure_installed = { "rustywind" } },
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     vim.list_extend(
  --       opts.formatters_by_ft.javascriptreact or {},
  --       { "rustywind" }
  --     )
  --   end,
  -- },
}
