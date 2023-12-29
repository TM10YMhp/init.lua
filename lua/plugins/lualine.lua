return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local function template_diagnostic(sources)
      return {
        'diagnostics',
        sources = { sources },
        fmt = function(str) return str:gsub(':', '') end
      }
    end

    local function lsp_client_names()
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()

      if next(clients) == nil then
        return buf_ft
      end
      return '['..#clients..']'..buf_ft
    end

    local function cursor_position()
      if
        vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 1024
      then
        return "File too long"
      else
        return '%l:%v|%{virtcol("$")-1}'
      end
    end

    local filesize = {
      'filesize',
      fmt = function(str) return str.upper(str) end
    }

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
        lualine_c = { cursor_position },
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
          template_diagnostic('nvim_workspace_diagnostic'),
          'o:encoding',
          'o:fileformat',
          lsp_client_names
        },
        lualine_y = { filesize },
        lualine_z = {'%L'},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { cursor_position },
        lualine_x = { filesize },
        lualine_y = {'%L'},
        lualine_z = {},
      },
    }
  end
}
