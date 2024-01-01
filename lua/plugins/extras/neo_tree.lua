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
      "ahmedkhalf/project.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree",
      },
      {
        "<leader>ge",
        "<cmd>Neotree toggle git_status<cr>",
        desc = "Explorer NeoTree",
      },
      {
        "<leader>be",
        "<cmd>Neotree toggle buffers<cr>",
        desc = "Explorer NeoTree",
      },
    },
    opts = {
      event_handlers = {
        {
          event = "file_open_requested",
          handler = function(args)
            local state = args.state
            local path = args.path
            local open_cmd = args.open_cmd or "edit"

            -- use last window if possible
            local suitable_window_found = false
            local nt = require("neo-tree")
            if nt.config.open_files_in_last_window then
              local prior_window = nt.get_prior_window()
              if prior_window > 0 then
                local success = pcall(vim.api.nvim_set_current_win, prior_window)
                if success then
                  suitable_window_found = true
                end
              end
            end

            -- find a suitable window to open the file in
            if not suitable_window_found then
              if state.window.position == "right" then
                vim.cmd("wincmd t")
              else
                vim.cmd("wincmd w")
              end
            end
            -- local attempts = 0
            -- while attempts < 4 and vim.bo.filetype == "neo-tree" do
            --   attempts = attempts + 1
            --   vim.cmd("wincmd w")
            -- end
            -- if vim.bo.filetype == "neo-tree" then
            --   -- Neo-tree must be the only window, restore it's status as a sidebar
            --   local winid = vim.api.nvim_get_current_win()
            --   local width = require("neo-tree.utils").get_value(state, "window.width", 40)
            --   vim.cmd("vsplit " .. path)
            --   vim.api.nvim_win_set_width(winid, width)
            -- else
              vim.cmd(open_cmd .. " " .. path)
            -- end

            -- If you don't return this, it will proceed to open the file using built-in logic.
            return { handled = true }
          end
        },
      },
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
          { source = "document_symbols", display_name = " Symbols " },
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
            ["f"] = "telescope",
          }
        },
        commands = {
          telescope = function()
            require("telescope.builtin").find_files({
              prompt_title = "Neotree",
            })
          end,
        },
        -- Windows fix
        use_libuv_file_watcher = false,
        bind_to_cwd = true,
      },
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
