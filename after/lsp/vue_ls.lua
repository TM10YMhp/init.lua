local vue_language_server_path = vim.fn.expand(
  "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
)
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local filetypes = vim.lsp.config.vtsls.filetypes
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = vim.list_extend(filetypes, { "vue" }),
}
vim.lsp.config("vtsls", vtsls_config)

return {
  -- workspace_required = false,
}
