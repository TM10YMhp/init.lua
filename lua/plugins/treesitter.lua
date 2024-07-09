return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    opts = {
      endwise = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
      -- https://thevaluable.dev/tree-sitter-neovim-overview/
      parser_install_dir = vim.fn.stdpath("config"),
      ensure_installed = {
        "lua",
        "vimdoc",
        "jsonc",
        "markdown",
        "markdown_inline",
        "javascript",
        "typescript",
        "tsx",
        -- "css",
        -- "astro",
        -- "c",
        -- "cpp",
        -- "angular",
      },
      sync_install = true, -- async cpu cost
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      -- support blade
      local parser_config =
        require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      require("nvim-treesitter.install").prefer_git = false
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertCharPre",
    config = function()
      require("nvim-ts-autotag").setup()

      -- HACK: attach on init
      require("nvim-ts-autotag.internal").attach()
    end,
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "gS", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      {
        "<leader>zr",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Cellular Automaton: Make It Rain",
      },
      {
        "<leader>zs",
        "<cmd>CellularAutomaton scramble<CR>",
        desc = "Cellular Automaton: Scramble",
      },
      {
        "<leader>zg",
        "<cmd>CellularAutomaton game_of_life<CR>",
        desc = "Cellular Automaton: Game Of Life",
      },
    },
  },
}
