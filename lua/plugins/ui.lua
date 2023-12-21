return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        border = "single",
        relative = "editor",
        max_width = 120,
        min_width = 60,
      },
      select = {
        backend = { "builtin" },
        builtin = {
          border = "single",
          max_width = 120,
          min_width = 60,
        }
      }
    }
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      icons = {
        DEBUG = "D",
        ERROR = "E",
        INFO  = "I",
        TRACE = "T",
        WARN  = "W"
      },
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win, record)
        vim.api.nvim_win_set_config(win, {
          zindex = 100,
          border = "single",
          title = {{ record.title[1], "Notify" .. record.level .. "Border" }},
        })
      end,
      minimum_width = 30,
      stages = "no_animation",
      render = function(bufnr, notif, highlights)
        local namespace = require("notify.render.base").namespace()
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, notif.message)

        vim.api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
          hl_group = highlights.body,
          end_line = #notif.message - 1,
          end_col = #notif.message[#notif.message],
          priority = 50,
        })
      end,
      fps = 1,
      top_down = false,
    },
    config = function(_, opts)
      require("notify").setup(opts)

      vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
        config = config or {
          style = "minimal",
          border = "single",
        }
        config.focus_id = ctx.method
        if not (result and result.contents) then
          -- vim.notify('No information available')
          return
        end
        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          -- vim.notify('No information available')
          return
        end
        return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
      end

      vim.notify = require("notify")
    end
  },
  {
    "echasnovski/mini.tabline",
    event = "VeryLazy",
    opts = {
      show_icons = false,
      set_vim_settings = false,
      tabpage_section = 'right'
    },
    config = function(_, opts)
      require('mini.tabline').setup(opts)

      vim.opt.showtabline = 2
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local template_diagnostic = function(sources)
        return {
          'diagnostics',
          sources = { sources },
          fmt = function(str) return str:gsub(':', '') end
        }
      end

      local winbar_config = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          template_diagnostic('nvim_diagnostic'),
          {
            function()
              local data = ''
              local symbol = vim.bo.modified and '* ' or '> '

              if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
                data = vim.fn.expand('%:~:.') or '[No Name]'
              else
                data = vim.fn.expand('%:t')
              end

              if data == '' then
                data = '[No Name]'
              end

              return symbol..data
            end,
            padding = 0,
            color = "Normal"
          }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }

      local function lsp_client_names()
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()

        if next(clients) == nil then
          return buf_ft
        end
        return '['..#clients..']'..buf_ft
      end

      local filesize = {
        'filesize',
        fmt = function(str) return str.upper(str) end
      }

      local function cursor_position()
        if
          vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 1024
        then
          return "File too long"
        else
          return '%l:%v|%{virtcol("$")-1}'
        end
      end

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
        winbar = winbar_config,
        inactive_winbar = winbar_config
      }
    end
  },
}
