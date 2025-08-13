return {
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
}
