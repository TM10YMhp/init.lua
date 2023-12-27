return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = "Neotree",
    branch = "v3.x",
    event = function()
      local bufname = vim.api.nvim_buf_get_name(0)
      if vim.fn.isdirectory(bufname) == 1 then
        return { "BufEnter" }
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "ahmedkhalf/project.nvim",
    },
    keys = {
      {
        "<leader>ee",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree",
      },
      {
        "<leader>eg",
        "<cmd>Neotree toggle git_status<cr>",
        desc = "Explorer NeoTree",
      },
      {
        "<leader>eb",
        "<cmd>Neotree toggle buffers<cr>",
        desc = "Explorer NeoTree",
      },
    },
    opts = {
      popup_border_style = "single",
      -- enable_git_status = false,
      -- enable_diagnostics = false,
      -- use_popups_for_input = false,
      resize_timer_interval = 1500,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = " Files " },
          { source = "buffers", display_name = " Buffers " },
          { source = "git_status", display_name = " Git " },
        },
        tabs_layout = "center",
        separator = "|",
      },
      -- open_files_do_not_replace_types = {
      --   "terminal",
      --   "Trouble",
      --   "trouble",
      --   "qf",
      --   "Outline",
      -- },
      default_component_configs = {
        container = {
          enable_character_fade = false,
        },
        indent = {
          padding = 0,
          expander_collapsed = ">",
          expander_expanded = "v",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = ""
        },
        name = {
          trailing_slash = true,
        },
        git_status = {
          symbols = {
            -- Change type
            added     = "",
            modified  = "",
            deleted   = "D",
            renamed   = "R",
            -- Status type
            untracked = "U",
            ignored   = "I",
            unstaged  = "M",
            staged    = "A",
            conflict  = "C",
          }
        },
        file_size = {
          enabled = true,
          required_width = 64,
        },
        type = {
          enabled = true,
          required_width = 122,
        },
        last_modified = {
          enabled = true,
          required_width = 88,
        },
        created = {
          enabled = true,
          required_width = 110,
        },
        symlink_target = {
          enabled = false,
        },
      },
      window = {
        position = "right",
        width = 35,
      },
      filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          hide_dotfiles = false,
          -- hide_hidden = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        window = {
          mappings = {
            ["/"] = "none",
            ["F"] = "fuzzy_finder",
          }
        },
        -- Windows fix
        use_libuv_file_watcher = false,
        bind_to_cwd = true,
      }
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      options = {
        disabled_filetypes = {
          winbar = { 'neo-tree' },
        },
      }
    }
  }
}
