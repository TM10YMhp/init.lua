return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- PERF: we don't need this
    local lualine_require = require("lualine_require")
    lualine_require.require = require

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
          tabline = 0,
          winbar = 0,
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
        lualine_c = { SereneNvim.lualine.cursor_position },
        lualine_x = {
          SereneNvim.lualine.diff,
          SereneNvim.lualine.workspace_diagnostics,
          "o:encoding",
          "o:fileformat",
          SereneNvim.lualine.lsp_client_names,
        },
        lualine_y = { filesize },
        lualine_z = { "%L" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { SereneNvim.lualine.cursor_position },
        lualine_x = { filesize },
        lualine_y = { "%L" },
        lualine_z = {},
      },
    }
  end,
}
