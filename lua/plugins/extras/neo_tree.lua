return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = "Neotree",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>fe",
      "<cmd>Neotree toggle<cr>",
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
    popup_border_style = "single",
    -- enable_git_status = false,
    -- enable_diagnostics = false,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
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
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,
      },
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true
      },
      use_libuv_file_watcher = true
    }
  }
}
