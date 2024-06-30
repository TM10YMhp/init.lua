return {
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
  settings = {
    typescript = {
      -- implementationsCodeLens = { enabled = true },
      -- referencesCodeLens = {
      --   enabled = true,
      --   showOnAllFunctions = true,
      -- },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      -- implementationsCodeLens = { enabled = true },
      -- referencesCodeLens = {
      --   enabled = true,
      --   showOnAllFunctions = true,
      -- },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
