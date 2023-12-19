return {
  {
    "echasnovski/mini.tabline",
    event = "VeryLazy",
    opts = {
      show_icons = false,
      set_vim_settings = false,
      tabpage_section = 'right'
    },
    config = function(_, opts)
      require('mini.tabline').setup(opts)

      vim.opt.showtabline = 2
    end
  },
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "o", "x" }, desc = "Around textobject" },
      { "i", mode = { "o", "x" }, desc = "Inside textobject" },
    },
    opts = {
      mappings = {
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
        goto_left = '',
        goto_right = '',
      },
      n_lines = 500
    }
  },
  {
    "echasnovski/mini.jump2d",
    keys = {
      {
        "<cr>",
        "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        mode = { "n", "x" },
        desc = "Start 2d jumping",
      }
    },
    opts = {
      mappings = { start_jumping = "" }
    },
  },
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align" },
      { "gA", mode = { "n", "x" }, desc = "Align with preview" },
    },
    opts = {}
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<M-k>", desc = "Move line up" },
      { "<M-j>", desc = "Move line down" },
      { "<M-h>", desc = "Move line left" },
      { "<M-l>", desc = "Move line right" },

      { "<M-k>", mode = "x", desc = "Move up" },
      { "<M-j>", mode = "x", desc = "Move down" },
      { "<M-h>", mode = "x", desc = "Move left" },
      { "<M-l>", mode = "x", desc = "Move right" },
    },
    opts = {}
  },
  {
    "echasnovski/mini.jump",
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = 'Jump forward' },
      { "F", mode = { "n", "x", "o" }, desc = 'Jump backward' },
      { "t", mode = { "n", "x", "o" }, desc = 'Jump forward till' },
      { "T", mode = { "n", "x", "o" }, desc = 'Jump backward till' },
    },
    opts = { delay = { highlight = 0 } }
  },
}
