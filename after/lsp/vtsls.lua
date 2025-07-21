local vue_language_server_path = vim.fn.expand(
  "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
)
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
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
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
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
