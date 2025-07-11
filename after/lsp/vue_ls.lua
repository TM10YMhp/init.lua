local vue_language_server_path = vim.fn.expand(
  "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
)

local config = vim.lsp.config.ts_ls
vim.lsp.config("ts_ls", {
  filetypes = vim.tbl_extend("force", config.filetypes, { "vue" }),
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
    },
  },
})

local lspconfig_name = "vue_ls"
local ok, config =
  pcall(require, ("mason-lspconfig.lsp.%s"):format(lspconfig_name))
if ok then vim.lsp.config(lspconfig_name, config) end

return {
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
  workspace_required = false,
}
