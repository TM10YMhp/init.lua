local lspconfig_name = "astro"
local ok, config =
  pcall(require, ("mason-lspconfig.lsp.%s"):format(lspconfig_name))
if ok then vim.lsp.config(lspconfig_name, config) end

return {}
