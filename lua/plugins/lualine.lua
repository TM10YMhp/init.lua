return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- PERF: we don't need this
    local lualine_require = require("lualine_require")
    lualine_require.require = require

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
          -- stylua: ignore
          { "mode", fmt = function(str) return str:sub(1, 1) end },
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
    }
  end,
  config = function(_, opts)
    require("lualine").setup(opts)

    --- HACK: reload diff colors
    vim.api.nvim_clear_autocmds({
      event = { "ColorScheme" },
      group = "lualine",
    })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("Lualine_TM", { clear = true }),
      desc = "Set highlight",
      callback = function()
        local diff = SereneNvim.lualine.diff

        diff.diff_color.added.fg = diff.reload_color.added.fg()
        diff.diff_color.modified.fg = diff.reload_color.modified.fg()
        diff.diff_color.removed.fg = diff.reload_color.removed.fg()

        require("lualine").setup(opts)
      end,
    })
  end,
}
