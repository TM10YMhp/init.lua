return {
  "tsserver",
  setup = function()
    return {
      --root_dir = require('lspconfig').util.root_pattern(
      --  "package.json", "tsconfig.json", "jsconfig.json", ".git"
      --),
      -- cmd = { "typescript-language-server", "--stdio" },
      init_options = {
        -- disableAutomaticTypingAcquisition = true,
        -- preferences = {
        --   quotePreference = "double",
        --   includeAutomaticOptionalChainCompletions = false,
        --   importModuleSpecifierPreference = "shortest",
        --   importModuleSpecifierEnding = "minimal",
        --   includeInlayParameterNameHints = "none",
        --   includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --   includeInlayFunctionParameterTypeHints = false,
        --   includeInlayVariableTypeHints = false,
        --   includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --   includeInlayPropertyDeclarationTypeHints = false,
        --   includeInlayFunctionLikeReturnTypeHints = false,
        --   includeInlayEnumMemberValueHints = false,
        -- },
        tsserver = {
          logVerbosity = 'off',
          trace = 'off',
          useSyntaxServer = 'never'
        },
      },
      -- settings = {
      --   --completions = { completeFunctionCalls = true },
      -- }
    }
  end
}
