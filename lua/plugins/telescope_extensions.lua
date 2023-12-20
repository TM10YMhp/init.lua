return {
  "telescope.nvim",
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require("telescope").load_extension("fzf")
      end
    },
    {
      "nvim-telescope/telescope-symbols.nvim",
      keys = {
        { "<leader>ss", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
        {
          "<leader>se",
          "<cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji'} }<cr>",
          desc = "Emoji",
        },
        {
          "<leader>sk",
          "<cmd>lua require'telescope.builtin'.symbols{ sources = {'kaomoji'} }<cr>",
          desc = "Kaomoji",
        },
        {
          "<leader>sg",
          "<cmd>lua require'telescope.builtin'.symbols{ sources = {'gitmoji'} }<cr>",
          desc = "Gitmoji",
        },
      }
    },
    {
      "debugloop/telescope-undo.nvim",
      keys = {
        { "<leader>eu", "<cmd>Telescope undo<cr>", desc = "Undo" },
      },
      config = function()
        require("telescope").load_extension("undo")
      end
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      keys = {
        { "<leader>elG", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep Args" },
      },
      config = function()
        require("telescope").load_extension("live_grep_args")
      end
    },
    {
      "alan-w-255/telescope-mru.nvim",
      dependencies = {
        { "yegappan/mru", event = "VeryLazy" },
      },
      keys = {
        { "<leader>eo", "<cmd>Telescope mru<cr>", desc = "MRU" },
      },
      config = function()
        require("telescope").load_extension("mru")
      end
    },
  },
}
