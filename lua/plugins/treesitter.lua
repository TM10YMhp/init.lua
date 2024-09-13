return {
  {
    "oncomouse/nvim-treesitter-endwise",
    event = SereneNvim.lazy_init and "BufAdd" or "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-endwise").setup()

      vim.api.nvim_exec_autocmds(
        "FileType",
        { group = "NvimTreesitter-endwise", modeline = false }
      )
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = SereneNvim.lazy_init and "BufAdd" or "VeryLazy",
    cmd = "TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- https://github.com/folke/lazy.nvim/commit/1f7b720
    opts_extend = { "ensure_installed" },
    opts = {
      -- https://thevaluable.dev/tree-sitter-neovim-overview/
      parser_install_dir = vim.fn.stdpath("config"),
      ensure_installed = {
        "vimdoc",
        "markdown",
        "markdown_inline",
        -- "css",
        -- "c",
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
      -- git slow in windows
      require("nvim-treesitter.install").prefer_git = false
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = SereneNvim.lazy_init and "BufAdd" or "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
      require("nvim-ts-autotag.internal").attach()
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      { "gS", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
  },
}
