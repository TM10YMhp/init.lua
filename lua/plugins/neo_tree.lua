return {
  {
    "s1n7ax/nvim-window-picker",
    keys = {
      {
        "<leader>ww",
        function()
          local picked_window_id = require("window-picker").pick_window()
            or vim.api.nvim_get_current_win()

          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick Window",
      },
    },
    opts = { hint = "statusline-winbar" },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
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
        "<leader>se",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            -- dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree",
      },
      {
        "<leader>sE",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            dir = vim.fn.expand("%:p:h"),
          })
        end,
        desc = "Explorer NeoTree in current file",
      },
      {
        "<leader>ge",
        "<cmd>Neotree toggle git_status<cr>",
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        "<cmd>Neotree toggle buffers<cr>",
        desc = "Buffer Explorer",
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
          default = "",
        },
        name = {
          trailing_slash = true,
        },
        git_status = {
          -- stylua: ignore
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
          },
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
        width = 33,
      },
      filesystem = {
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        window = {
          -- stylua: ignore
          mappings = {
            ["space"] = "none",
            ["/"] = "none",
            ["F"] = "telescope_find",
            ["f"] = "telescope_find_root",
            ["G"] = "telescope_grep",
            ["g"] = "telescope_grep_root",
            ["P"] = {
              "toggle_preview",
              config = { use_float = false, use_image_nvim = false },
            },
          },
        },
        -- NOTE: libuv crash in Windows
        use_libuv_file_watcher = false,
        bind_to_cwd = true,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      local function getTelescopeNode(state, path, builtin_name)
        return {
          cwd = path,
          prompt_title = builtin_name .. " | <CR> Open | <C-s> Navigate",
          attach_mappings = function(prompt_bufnr, map)
            local actions = require("telescope.actions")
            local telescope_actions =
              require("telescope.actions.mt").transform_mod({
                navigate = function()
                  actions.close(prompt_bufnr)
                  local action_state = require("telescope.actions.state")
                  local selection = action_state.get_selected_entry()
                  local filename = selection.filename
                  if filename == nil then
                    filename = selection[1]
                  end
                  require("neo-tree.sources.filesystem").navigate(
                    state,
                    state.path,
                    -- TODO: fix this
                    filename:gsub("/", "\\")
                  )
                end,
              })

            map({ "i", "n" }, "<C-s>", telescope_actions.navigate)

            return true
          end,
        }
      end

      local function getTelescopeBuiltin(builtin_name, state, path)
        local builtin = {
          live_grep = require("telescope.builtin").live_grep,
          find_files = require("telescope.builtin").find_files,
        }
        local _builtin_name = builtin_name == "live_grep" and "Live Grep"
          or "Find Files"

        return builtin[builtin_name](
          getTelescopeNode(state, path, _builtin_name)
        )
      end

      opts.commands = {
        telescope_find = function(state)
          if state.tree == nil then
            return
          end
          local node = state.tree:get_node()
          local path = node:get_id()
          if vim.fn.isdirectory(path) == 0 then
            path = node._parent_id
          end
          getTelescopeBuiltin("find_files", state, path)
        end,
        telescope_find_root = function(state)
          if state.tree == nil then
            return
          end
          local path = state.tree.nodes.root_ids[1]
          getTelescopeBuiltin("find_files", state, path)
        end,
        telescope_grep = function(state)
          if state.tree == nil then
            return
          end
          local node = state.tree:get_node()
          local path = node:get_id()
          if vim.fn.isdirectory(path) == 0 then
            path = node._parent_id
          end
          getTelescopeBuiltin("live_grep", state, path)
        end,
        telescope_grep_root = function(state)
          if state.tree == nil then
            return
          end
          local path = state.tree.nodes.root_ids[1]
          getTelescopeBuiltin("live_grep", state, path)
        end,
      }
    end,
  },
}
