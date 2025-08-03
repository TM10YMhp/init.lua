return {
  -- { import = "plugins.extras.coding.blink" },
  -- { import = "plugins.extras.coding.colorful_menu" },
  -- { import = "plugins.extras.coding.luasnip" },

  -- { import = "plugins.extras.editor.conform" },
  -- { import = "plugins.extras.editor.fzf" },
  -- { import = "plugins.extras.editor.refactoring" },
  -- { import = "plugins.extras.editor.todo_comments" },
  -- { import = "plugins.extras.editor.nvim_highlight_colors" },

  -- { import = "plugins.extras.ui.cokeline" },
  -- { import = "plugins.extras.ui.colorscheme" },
  -- { import = "plugins.extras.ui.heirline" },
  -- { import = "plugins.extras.ui.nvim_bqf" },
  -- { import = "plugins.extras.ui.treesitter_context" },

  -- { import = "plugins.extras.util.emoji" },
  -- { import = "plugins.extras.util.mini_clue" },

  -- {
  --   "mason-tool-installer.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     return {
  --       ensure_installed = vim.tbl_filter(
  --         function(x) return not vim.list_contains({ "tinymist", "eslint" }, x) end,
  --         opts.ensure_installed
  --       ),
  --     }
  --   end,
  -- },

  {
    "module-bigfile",
    dir = SereneNvim.get_module_dir("bigfile"),
    -- virtual = true,
    lazy = false,
    main = "bigfile",
    opts = {
      size = SereneNvim.config.bigfile_size,
    },
  },
  {
    "module-fix-auto-scroll",
    dir = SereneNvim.get_module_dir("fix-auto-scroll"),
    event = "BufLeave",
    main = "fix-auto-scroll",
    config = true,
  },

  -- {
  --   "BranimirE/fix-auto-scroll.nvim",
  --   event = "BufLeave",
  --   config = true,
  -- },

  {
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    keys = {
      { "<leader>ug", "<cmd>GrugFar<cr>", desc = "Grug Far" },
    },
    opts = {
      transient = true,
      windowCreationCommand = "botright split",
      showCompactInputs = true,
      openTargetWindow = {
        preferredLocation = "prev",
      },
      icons = { enabled = true },
      keymaps = {
        openNextLocation = { n = "" },
        openPrevLocation = { n = "" },
      },
    },
  },

  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
    opts = {
      overwrite = {
        yank = { enabled = false },
        search = { enabled = false },
        paste = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffText",
              max_duration = 500,
              min_duration = 500,
            },
          },
          paste_mapping = "p",
          Paste_mapping = "P",
        },
        undo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffDelete",
              max_duration = 500,
              min_duration = 500,
            },
          },
          undo_mapping = "u",
        },
        redo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffAdd",
              max_duration = 500,
              min_duration = 500,
            },
          },
          redo_mapping = "<c-r>",
        },
      },
    },
  },
}
