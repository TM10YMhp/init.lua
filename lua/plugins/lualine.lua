return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local extract_color_from_hllist =
      require("lualine.utils.utils").extract_color_from_hllist

    local function template_diagnostic(sources)
      return {
        "diagnostics",
        diagnostics_color = {
          error = {
            fg = extract_color_from_hllist(
              { "fg", "sp" },
              { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
              "NONE"
            ),
          },
          warn = {
            fg = extract_color_from_hllist(
              { "fg", "sp" },
              { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
              "NONE"
            ),
          },
          info = {
            fg = extract_color_from_hllist(
              { "fg", "sp" },
              { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "Normal" },
              "NONE"
            ),
          },
          hint = {
            fg = extract_color_from_hllist(
              { "fg", "sp" },
              { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffChange" },
              "NONE"
            ),
          },
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

    local winbar_config = {
      lualine_c = {
        {
          function()
            local data = ""

            if vim.api.nvim_buf_get_option(0, "buftype") == "" then
              data = vim.fn.expand("%:~:.") or "[No Name]"
            else
              data = vim.fn.expand("%:t")
            end

            if data == "" then
              data = "[No Name]"
            end

            return "> " .. data
          end,
          padding = 0,
          color = "WinBar",
        },
      },
    }

    return {
      options = {
        icons_enabled = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 0,
          winbar = 0,
        },
        disabled_filetypes = {
          statusline = {},
          winbar = { "dbui", "neo-tree", "dashboard" },
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
              added = {
                fg = extract_color_from_hllist("fg", {
                  "LuaLineDiffAdd",
                  "GitSignsAdd",
                  "GitGutterAdd",
                  "DiffAdded",
                  "DiffAdd",
                }, "NONE"),
              },
              modified = {
                fg = extract_color_from_hllist("fg", {
                  "LuaLineDiffChange",
                  "GitSignsChange",
                  "GitGutterChange",
                  "DiffChanged",
                  "DiffChange",
                }, "NONE"),
              },
              removed = {
                fg = extract_color_from_hllist("fg", {
                  "LuaLineDiffDelete",
                  "GitSignsDelete",
                  "GitGutterDelete",
                  "DiffRemoved",
                  "DiffDelete",
                }, "NONE"),
              },
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
      winbar = winbar_config,
      inactive_winbar = winbar_config,
    }
  end,
}
