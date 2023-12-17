return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '-' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      update_debounce = 1000,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      preview_config = { row = 1 }
    },
    keys = {
      {
        "<leader>ug",
        "<cmd>Gitsigns toggle_signs<cr>",
        desc = "Toggle Git Signs"
      },
      {
        "<leader>ub",
        "<cmd>Gitsigns toggle_current_line_blame<cr>",
        desc = "Toggle Git Line Blame"
      },
      {
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        mode = { "o", "x" },
        desc = "Select Hunk"
      },
      {
        "]h",
        function() require('gitsigns').next_hunk() end,
        desc = "Next Hunk"
      },
      {
        "[h",
        function() require('gitsigns').prev_hunk() end,
        desc = "Prev Hunk"
      },
      {
        "<leader>hb",
        function()
          require('gitsigns').blame_line({ full = true })
        end,
        desc = "Blame Line"
      },
      {
        "<leader>hu",
        function() require('gitsigns').undo_stage_hunk() end,
        desc = "Undo Stage Hunk"
      },
      {
        "<leader>hp",
        function() require('gitsigns').preview_hunk() end,
        desc = "Preview Hunk"
      },
      {
        "<leader>hs",
        "<cmd>exe 'Gitsigns stage_hunk'|w<cr>",
        desc = "Stage Hunk"
      },
      {
        "<leader>hs",
        [[:<c-u>exe "'<,'>Gitsigns stage_hunk"|w<cr>]],
        mode = "x",
        desc = "Stage Hunk"
      },
      {
        "<leader>hr",
        ":Gitsigns reset_hunk<CR>",
        mode = { "n", "x" },
        desc = "Reset Hunk"
      },
      {
        "<leader>hS",
        "<cmd>exe 'Gitsigns stage_buffer'|w<cr>",
        desc = "Stage Buffer"
      },
      {
        "<leader>hR",
        "<cmd>exe 'Gitsigns reset_buffer'|Gitsigns refresh<cr>",
        desc = "Reset Buffer"
      }
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
      { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffviewFileHistory" },
      { "<leader>dH", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffviewFileHistory" },
    },
    opts = {
      use_icons = false,
      signs = {
        fold_closed = ">",
        fold_open = "v",
        done = "✓",
      },
      view = {
        default = {
          layout = "diff2_vertical",
        },
        merge_tool = {
          layout = "diff3_vertical",
        },
        file_history = {
          layout = "diff2_vertical",
        },
      },
      file_panel = {
        win_config = {
          position = "right",
          width = 35,
        }
      }
    }
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      {
        "<leader>gb",
        ":G blame<cr>",
        mode = { "n", "x" },
        desc = "Git Blame"
      },
    },
  },
}
