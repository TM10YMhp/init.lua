return {
  -- base
  {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    opts_extend = { "clues", "triggers" },
    opts = function()
      local miniclue = require("mini.clue")

      -- fix refactoring.nvim problems
      vim.api.nvim_create_autocmd("CmdlineEnter", {
        callback = function(args)
          vim.schedule_wrap(miniclue.disable_all_triggers)()
        end,
      })
      vim.api.nvim_create_autocmd("CmdlineLeave", {
        callback = function(args)
          vim.schedule_wrap(miniclue.enable_all_triggers)()
        end,
      })

      return {
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      }
    end,
  },
  -- custom
  {
    "mini.clue",
    opts = {
      clues = {
        { mode = "n", keys = "<leader><tab>", desc = "+tabs" },
        { mode = "n", keys = "<leader>b", desc = "+buffer" },
        { mode = "n", keys = "<leader>c", desc = "+code" },
        { mode = "n", keys = "<leader>d", desc = "+diff" },
        { mode = "n", keys = "<leader>g", desc = "+git" },
        { mode = "n", keys = "<leader>h", desc = "+hunk" },
        { mode = "n", keys = "<leader>i", desc = "+insert" },
        { mode = "n", keys = "<leader>s", desc = "+search" },
        { mode = "n", keys = "<leader>o", desc = "+toggle" },
        { mode = "n", keys = "<leader>u", desc = "+ui" },
        { mode = "n", keys = "<leader>x", desc = "+diagnostics/quickfix" },
      },
      window = {
        delay = 200,
        config = {
          border = "single",
          width = 40,
          -- width = "auto",
          -- TODO: create util
          -- width = math.floor(math.max(30, math.min(60, vim.o.columns * 0.5))),
        },
      },
    },
  },
}
