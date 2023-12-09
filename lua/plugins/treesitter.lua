return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      "RRethy/nvim-treesitter-endwise",
    },
    event = "VeryLazy",
    config = function()
      require('nvim-treesitter.install').prefer_git = false

      require("nvim-treesitter.configs").setup({
        parser_install_dir = vim.fn.stdpath("config"),
        ensure_installed = {
          "lua",
          "javascript",
          "typescript",
          "css",
          "tsx",
          "astro",
          -- rest.nvim
          "html",
          "http",
          "json",
        },
        sync_install = true, -- async cpu cost
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        -- nvim-treesitter-endwise
        endwise = { enable = true },
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-ts-autotag").setup({
        enable_close_on_slash = false
      })

      require('nvim-ts-autotag.internal').attach()
    end
  },
  {
    "Wansmer/treesj",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })

      vim.keymap.set(
        "n",
        "gS",
        "<cmd>lua require('treesj').toggle()<cr>",
        { desc = "Toggle Split Join" }
      )
    end
  },
  {
    "Eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.keymap.set('n', '<leader>mr', '<cmd>CellularAutomaton make_it_rain<CR>', {
        desc = "Cellular Automaton: Make It Rain"
      })
      vim.keymap.set('n', '<leader>ms', '<cmd>CellularAutomaton scramble<CR>', {
        desc = "Cellular Automaton: Scramble"
      })
      vim.keymap.set('n', '<leader>mg', '<cmd>CellularAutomaton game_of_life<CR>', {
        desc = "Cellular Automaton: Game Of Life"
      })
    end
  },
}
