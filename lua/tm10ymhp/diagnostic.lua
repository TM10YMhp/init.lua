local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.max_width = 80
  opts.max_height = 35
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     float = { style = "minimal" },
--     underline = false,
--     update_in_insert = false,
--     virtual_text = false,
--     severity_sort = true,
--   }
-- )

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    style = "minimal",
    border = "single",
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    style = "minimal",
    border = "single",
  }
)

vim.diagnostic.config{
  float = {
    style = "minimal",
    border = "single",
    source = "always",
  },
  underline = false,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
}
