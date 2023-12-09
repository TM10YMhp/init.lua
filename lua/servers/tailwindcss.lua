return {
  "tailwindcss",
  -- enabled = false,
  setup = function()
    return {
      root_dir = require("lspconfig").util.root_pattern(
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.mjs',
        'tailwind.config.ts'
      ),
      settings = {
        tailwindCSS = {
          hovers = true,
          suggestions = true,
          emmetCompletions = false,
          colorDecorators = false,
          codeActions = false,
          experimental = {
            classRegex = {
              {"cva\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)", "\"(.*?)\""},
              {"cx\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)", "\"(.*?)\""},
              {"twMerge\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)", "\"(.*?)\""},
              {"cn\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)", "\"(.*?)\""},
            }
          }
        }
      }
    }
  end
}
