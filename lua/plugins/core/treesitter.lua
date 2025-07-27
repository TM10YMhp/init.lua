return {
  {
    "nvim-treesitter",
    optional = true,
    dependencies = { "metiulekm/nvim-treesitter-endwise" },
    opts = {
      endwise = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    cmd = { "TSUpdate", "TSInstall", "TSModuleInfo", "TSInstallInfo" },
    init = function(plugin)
      -- https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    -- https://github.com/folke/lazy.nvim/commit/1f7b720
    opts_extend = { "ensure_installed" },
    opts = {
      -- https://thevaluable.dev/tree-sitter-neovim-overview/
      parser_install_dir = vim.fn.expand(vim.fn.stdpath("config") .. "/after"),
      ensure_installed = {
        "bash",
        "vim",
        "query",
        "vimdoc",
        "markdown",
        "markdown_inline",
      },
      sync_install = true, -- async cpu cost
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
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
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)

      -- HACK: attach not work bufnr
      SereneNvim.bufdo(function(bufnr)
        if vim.api.nvim_get_current_buf() == bufnr then return end
        vim.api.nvim_buf_call(
          bufnr,
          function() require("nvim-ts-autotag.internal").attach() end
        )
      end)
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
