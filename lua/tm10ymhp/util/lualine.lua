local get_hl_from_hllist = function(hllist)
  for _, hl_name in ipairs(hllist) do
    if vim.fn.hlexists(hl_name) ~= 0 then
      return hl_name
    end
  end
  return "Ignore"
end

local M = {}

M.lsp_client_names = function()
  local buf_ft = vim.api.nvim_get_option_value("filetype", {})
  local clients = vim.lsp.get_clients()

  if next(clients) == nil then
    return buf_ft
  end
  return "[" .. #clients .. "]" .. buf_ft
end

M.filesize = {
  "filesize",
  fmt = function(str)
    return str.upper(str)
  end,
}

M.cursor_position = function()
  if vim.fn.getfsize(vim.fn.expand("%")) > 1024 * 1024 then
    return "Bigfile"
  else
    return '%l:%v|%{virtcol("$")-1}'
  end
end

M.workspace_diagnostics = {
  "diagnostics",
  diagnostics_color = {
    error = get_hl_from_hllist({
      "DiagnosticError",
      "LspDiagnosticsDefaultError",
      "DiffDelete",
    }),
    warn = get_hl_from_hllist({
      "DiagnosticWarn",
      "LspDiagnosticsDefaultWarning",
      "DiffText",
    }),
    info = get_hl_from_hllist({
      "DiagnosticInfo",
      "LspDiagnosticsDefaultInformation",
      "Normal",
    }),
    hint = get_hl_from_hllist({
      "DiagnosticHint",
      "LspDiagnosticsDefaultHint",
      "DiffChange",
    }),
  },
  sources = { "nvim_workspace_diagnostic" },
  fmt = function(str)
    return str:gsub(":", "")
  end,
}

M.diff = {
  "diff",
  diff_color = {
    added = get_hl_from_hllist({
      "LuaLineDiffAdd",
      "GitSignsAdd",
      "GitGutterAdd",
      "DiffAdded",
      "DiffAdd",
    }),
    modified = get_hl_from_hllist({
      "LuaLineDiffChange",
      "GitSignsChange",
      "GitGutterChange",
      "DiffChanged",
      "DiffChange",
    }),
    removed = get_hl_from_hllist({
      "LuaLineDiffDelete",
      "GitSignsDelete",
      "GitGutterDelete",
      "DiffRemoved",
      "DiffDelete",
    }),
  },
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
}

return M
