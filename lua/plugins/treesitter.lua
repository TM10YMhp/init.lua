return {
  {
    "andrewferrier/debugprint.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      "gbp",
      "gbP",
      "gbv",
      "gbV",
      "gbo",
      "gbO",
      { "gbv", mode = "x" },
      { "gbV", mode = "x" },
    },
    opts = {
      keymaps = {
        normal = {
          plain_below = "gbp",
          plain_above = "gbP",
          variable_below = "gbv",
          variable_above = "gbV",
          textobj_below = "gbo",
          textobj_above = "gbO",
        },
        visual = {
          variable_below = "gbv",
          variable_above = "gbV",
        },
      },
      commands = {
        toggle_comment_debug_prints = "",
        delete_debug_prints = "",
      },
      display_counter = false,
      display_snippet = false,
      print_tag = "Debug",
    },
  },
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
