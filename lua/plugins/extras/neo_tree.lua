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
      "<leader>f",
      "<cmd>Neotree toggle<cr>",
      desc = "Explorer NeoTree",
    },
  },
  opts = {
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
    },
    window = {
      position = "right",
      width = 35,
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true
      },
      use_libuv_file_watcher = true
    }
  }
}
