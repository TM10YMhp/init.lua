return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local get_hl_from_hllist = function(hllist)
      for _, hl_name in ipairs(hllist) do
        if vim.fn.hlexists(hl_name) ~= 0 then
          return hl_name
        end
      end
      return "Ignore"
    end

    local function template_diagnostic(sources)
      return {
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
        sources = { sources },
        fmt = function(str)
          return str:gsub(":", "")
        end,
      }
    end

    local function lsp_client_names()
      local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
      local clients = vim.lsp.get_active_clients()

      if next(clients) == nil then
        return buf_ft
      end
      return "[" .. #clients .. "]" .. buf_ft
    end

    local function cursor_position()
      if vim.fn.getfsize(vim.fn.expand("%")) > 1024 * 1024 then
        return "Bigfile"
      else
        return '%l:%v|%{virtcol("$")-1}'
      end
    end

    local filesize = {
      "filesize",
      fmt = function(str)
        return str.upper(str)
      end,
    }

    return {
      options = {
        icons_enabled = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 1000,
        },
        disabled_filetypes = {
          statusline = {},
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = { "b:gitsigns_head" },
        lualine_c = { cursor_position },
        lualine_x = {
          {
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
          },
          template_diagnostic("nvim_workspace_diagnostic"),
          "o:encoding",
          "o:fileformat",
          lsp_client_names,
        },
        lualine_y = { filesize },
        lualine_z = { "%L" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { cursor_position },
        lualine_x = { filesize },
        lualine_y = { "%L" },
        lualine_z = {},
      },
    }
  end,
}
