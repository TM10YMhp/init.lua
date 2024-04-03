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
      require("nvim-treesitter.install").prefer_git = false
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>ut",
        function()
          require("tm10ymhp.utils").info("Autotag: Attach")
          require("nvim-ts-autotag.internal").attach()
        end,
        desc = "Manually Attach Autotag",
      },
    },
    opts = {
      enable_rename = false,
      enable_close_on_slash = false,
    },
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)

      -- use Filetype to enable autotag
      require("nvim-ts-autotag.internal").attach()
    end,
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
