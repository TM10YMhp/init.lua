return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup({
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
      })

      vim.keymap.set("n", "<leader>ug", "<cmd>Gitsigns toggle_signs<cr>", {
        desc = "Toggle Git Signs"
      })
      vim.keymap.set("n", "<leader>ub", "<cmd>Gitsigns toggle_current_line_blame<cr>", {
        desc = "Toggle Git Line Blame"
      })

      vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {
        desc = "Select Hunk"
      })
      vim.keymap.set("n", "]h", gitsigns.next_hunk, {
        desc = "Next Hunk"
      })
      vim.keymap.set("n", "[h", gitsigns.prev_hunk, {
        desc = "Prev Hunk"
      })
      vim.keymap.set("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame Line" })
      vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, {
        desc = "Undo Stage Hunk"
      })
      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, {
        desc = "Preview Hunk"
      })
      vim.keymap.set("n", "<leader>hs",
        "<cmd>exe 'Gitsigns stage_hunk'|w<cr>",
        { desc = "Stage Hunk" }
      )
      vim.keymap.set("v", "<leader>hs",
        [[:<c-u>exe "'<,'>Gitsigns stage_hunk"|w<cr>]],
        { desc = "Stage Hunk" }
      )
      vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", {
        desc = "Reset Hunk"
      })
      vim.keymap.set("n", "<leader>hS",
        "<cmd>exe 'Gitsigns stage_buffer'|w<cr>",
        { desc = "Stage Buffer" }
      )
      vim.keymap.set("n", "<leader>hR",
        "<cmd>exe 'Gitsigns reset_buffer'|Gitsigns refresh<cr>",
        { desc = "Reset Buffer" }
      )
    end
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({
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
      })

      vim.keymap.set("n", "<leader>do", ":DiffviewOpen<cr>")
      vim.keymap.set("n", "<leader>dc", ":DiffviewClose<cr>")
      vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<cr>")
      vim.keymap.set("n", "<leader>dH", ":DiffviewFileHistory %<cr>")
    end
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      vim.keymap.set(
        { "n", "x" },
        "<leader>gb",
        ":G blame<cr>",
        { desc = "Git Blame" }
      )
    end
  },
}
