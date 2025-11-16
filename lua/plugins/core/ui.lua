return {
  {
    "r0nsha/multinput.nvim",
    init = function()
      SereneNvim.on_very_lazy(function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
          require("lazy").load({ plugins = { "multinput.nvim" } })
          return vim.ui.input(...)
        end
      end)
    end,
    opts = {},
  },
  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      view = {
        spacing = 0,
        header_lnum = true,
      },
    },
  },
  {
    "pechorin/any-jump.vim",
    cmd = { "AnyJump", "AnyJumpArg", "AnyJumpLastResults" },
    keys = {
      { "<leader>jj", "<cmd>AnyJump<cr>", desc = "AnyJump" },
      { "<leader>ja", ":AnyJumpArg ", desc = "AnyJumpArg" },
      {
        "<leader>jr",
        "<cmd>AnyJumpLastResults<cr>",
        desc = "AnyJumpLastResults",
      },
    },
    init = function() vim.g.any_jump_disable_default_keybindings = 1 end,
    config = function()
      vim.g.any_jump_grouping_enabled = 1
      vim.g.any_jump_preview_lines_count = 2

      vim.g.any_jump_window_width_ratio = 0.8
      vim.g.any_jump_window_height_ratio = 0.8
    end,
  },
  {
    "oskarrrrrrr/symbols.nvim",
    keys = {
      {
        "<leader>ss",
        "<cmd>SymbolsToggle<cr>",
        desc = "Toggle Symbols",
      },
    },
    config = function()
      local r = require("symbols.recipes")
      require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
        sidebar = {
          open_direction = "right",
          auto_resize = { min_width = 30 },
          show_inline_details = true,
          chars = {
            folded = ">",
            unfolded = "v",
            guide_vert = "│",
            guide_middle_item = "├",
            guide_last_item = "└",
            hl = "NonText",
          },
          keymaps = {
            ["<Left>"] = "fold",
            ["<Right>"] = "unfold",
          },
        },
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "DiffviewOpen" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
      {
        "<leader>dh",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "DiffviewFileHistory",
      },
      {
        "<leader>dH",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "DiffviewFileHistory",
      },
    },
    opts = {
      use_icons = false,
      signs = {
        fold_closed = "> ",
        fold_open = "v ",
        done = "✓",
      },
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      file_panel = {
        win_config = {
          position = "bottom",
          height = 16,
        },
      },
      hooks = {
        diff_buf_read = function()
          vim.opt_local.wrap = true
          vim.opt_local.list = false
        end,
      },
      keymaps = {
        view = {
          ["[x"] = false,
          ["]x"] = false,
        },
        file_panel = {
          ["[x"] = false,
          ["]x"] = false,
        },
      },
    },
  },
}
