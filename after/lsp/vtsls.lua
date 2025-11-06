return {
  init_options = {
    tsserver = {
      logVerbosity = "off",
      trace = "off",
      useSyntaxServer = "never",
    },
    -- preferences = {
    --   disableSuggestions = true,
    --   useLabelDetailsInCompletionEntries = false
    -- },
  },
  settings = {
    typescript = {
      -- implementationsCodeLens = { enabled = true },
      -- referencesCodeLens = {
      --   enabled = true,
      --   showOnAllFunctions = true,
      -- },
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      -- implementationsCodeLens = { enabled = true },
      -- referencesCodeLens = {
      --   enabled = true,
      --   showOnAllFunctions = true,
      -- },
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
