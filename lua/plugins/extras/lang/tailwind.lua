return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- only detect tailwind config files
          root_dir = require("lspconfig.util").root_pattern(
            "tailwind.config.js",
            "tailwind.config.cjs",
            "tailwind.config.mjs",
            "tailwind.config.ts"
          ),
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
}
