return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local Util = require("tm10ymhp.lualine")

    return {
      options = {
        icons_enabled = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline    = 1000,
          winbar     = 1000,
        }
      },
      sections = {
        lualine_a = {
          { 'mode', fmt = function(str) return str:sub(1,1) end }
        },
        lualine_b = { 'b:gitsigns_head' },
        lualine_c = { Util.cursor_position },
        lualine_x = {
          {
            'diff',
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed
                }
              end
            end
          },
          Util.template_diagnostic('nvim_workspace_diagnostic'),
          'o:encoding',
          'o:fileformat',
          Util.lsp_client_names
        },
        lualine_y = { Util.filesize },
        lualine_z = {'%L'},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { Util.cursor_position },
        lualine_x = { Util.filesize },
        lualine_y = {'%L'},
        lualine_z = {},
      },
      winbar = Util.winbar_config,
      inactive_winbar = Util.winbar_config
    }
  end
}
