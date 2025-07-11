return {
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      {
        "<leader>st",
        function() Snacks.picker.todo_comments() end,
        desc = "Todo",
      },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>su",
        function() Snacks.picker.undo() end,
        desc = "Undo",
      },
      {
        "<leader>sR",
        function() Snacks.picker.resume() end,
        desc = "Resume",
      },
    },
    opts = {
      picker = {
        sources = {
          explorer = {
            layout = {
              cycle = false,
              layout = { position = "right" },
            },
            win = {
              list = {
                keys = {
                  ["]w"] = false,
                  ["[w"] = false,
                  ["]e"] = false,
                  ["[e"] = false,
                },
              },
            },
          },
        },
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.85,
              {
                box = "vertical",
                border = "single",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                title = "{preview}",
                border = "single",
                width = 0.5,
              },
            },
          },
          vertical = {
            layout = {
              backdrop = false,
              width = 0.5,
              min_width = 80,
              height = 0.85,
              min_height = 30,
              box = "vertical",
              border = "single",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              {
                win = "preview",
                title = "{preview}",
                height = 0.5,
                border = "top",
              },
            },
          },
          sidebar = {
            layout = {
              backdrop = false,
              width = 33,
              min_width = 33,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "single",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              {
                win = "preview",
                title = "{preview}",
                height = 0.4,
                border = "top",
              },
            },
          },
        },
        prompt = "> ",
        win = {
          list = { wo = { foldcolumn = "0" } },
          preview = {
            wo = {
              signcolumn = "no",
              foldcolumn = "0",
            },
          },
        },
        icons = {
          files = { enabled = false },
          tree = {
            middle = "│ ",
          },
          undo = { saved = "[+] " },
          ui = {
            live = "L ",
            hidden = "h",
            ignored = "i",
            follow = "f",
            selected = "● ",
            unselected = "○ ",
          },
          git = { enabled = false },
          diagnostics = {
            Error = "E ",
            Warn = "W ",
            Hint = "H ",
            Info = "I ",
          },
        },
      },
    },
  },
}
