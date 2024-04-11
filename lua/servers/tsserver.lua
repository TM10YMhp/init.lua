return {
  "tsserver",
  -- enabled = false,
  setup = function()
    return {
      --root_dir = require('lspconfig').util.root_pattern(
      --  "package.json", "tsconfig.json", "jsconfig.json", ".git"
      --),
      -- cmd = { "typescript-language-server", "--stdio" },
      init_options = {
        tsserver = {
          logVerbosity = "off",
          trace = "off",
          useSyntaxServer = "never",
        },
        preferences = {
          disableSuggestions = true,
          useLabelDetailsInCompletionEntries = false,
        },
      },
      -- settings = {
      --   --completions = { completeFunctionCalls = true },
      -- },
    }
  end,
}
