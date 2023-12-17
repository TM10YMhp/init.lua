return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
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
          "markdown",
          "markdown_inline",
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
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('nvim-ts-autotag.internal').attach()
    end
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "gS", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>ar",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Cellular Automaton: Make It Rain",
      },
      {
        "<leader>as",
        "<cmd>CellularAutomaton scramble<CR>",
        desc = "Cellular Automaton: Scramble",
      },
      {
        "<leader>ag",
        "<cmd>CellularAutomaton game_of_life<CR>",
        desc = "Cellular Automaton: Game Of Life",
      },
    },
  },
}
