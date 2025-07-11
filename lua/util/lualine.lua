local lualine_utils = require("lualine.utils.utils")

---@class serenenvim.util.lualine
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

M.cursor_position = {
  '%l:%{charcol(".")}|%{charcol("$")-1}',
  cond = function()
    return vim.o.filetype ~= "bigfile"
  end,
}

M.workspace_diagnostics = {
  "diagnostics",
  diagnostics_color = {
    error = function()
      return {
        fg = lualine_utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
          "none"
        ),
      }
    end,
    warn = function()
      return {
        fg = lualine_utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
          "none"
        ),
      }
    end,
    info = function()
      return {
        fg = lualine_utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "Normal" },
          "none"
        ),
      }
    end,
    hint = function()
      return {
        fg = lualine_utils.extract_color_from_hllist(
          { "fg", "sp" },
          { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffChange" },
          "none"
        ),
      }
    end,
  },
  sources = { "nvim_workspace_diagnostic" },
  fmt = function(str)
    return str:gsub(":", "")
  end,
}

M.diff = {
  "diff",
  diff_color = {
    added = function()
      return {
        fg = lualine_utils.extract_color_from_hllist("fg", {
          "LuaLineDiffAdd",
          "GitSignsAdd",
          "GitGutterAdd",
          "DiffAdded",
          "DiffAdd",
        }, "none"),
      }
    end,
    modified = function()
      return {
        fg = lualine_utils.extract_color_from_hllist("fg", {
          "LuaLineDiffChange",
          "GitSignsChange",
          "GitGutterChange",
          "DiffChanged",
          "DiffChange",
        }, "none"),
      }
    end,
    removed = function()
      return {
        fg = lualine_utils.extract_color_from_hllist("fg", {
          "LuaLineDiffDelete",
          "GitSignsDelete",
          "GitGutterDelete",
          "DiffRemoved",
          "DiffDelete",
        }, "none"),
      }
    end,
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
