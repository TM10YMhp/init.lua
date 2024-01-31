return {
  "tailwindcss",
  -- enabled = false,
  setup = function()
    return {
      root_dir = require("lspconfig").util.root_pattern(
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
          classAttributes = { "class", "className", "ngClass", "classNames" },
          experimental = {
            classRegex = {
              {
                "cva\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
                '"(.*?)"',
              },
              {
                "cx\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
                '"(.*?)"',
              },
              {
                "twMerge\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
                '"(.*?)"',
              },
              {
                "cn\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
                '"(.*?)"',
              },
              {
                "cn\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
                '"(.*?)"',
              },
            },
          },
        },
      },
    }
  end,
}
