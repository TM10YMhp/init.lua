return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts, {
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
        lualine_y = { SereneNvim.lualine.filesize },
        lualine_z = { "%L" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { SereneNvim.lualine.cursor_position },
        lualine_x = { SereneNvim.lualine.filesize },
        lualine_y = { "%L" },
        lualine_z = {},
      },
    })
  end,
}
