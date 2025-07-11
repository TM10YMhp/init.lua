return {
  {
    "airblade/vim-rooter",
    event = "VeryLazy",
    init = function()
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        ".project",
        -- "Makefile",
        -- https://github.com/airblade/vim-rooter/issues/124
        -- "!../package.json",
        -- "!../../package.json",
        -- "package.json",
        ".root",
      }
    end,
    config = function()
      vim.api.nvim_exec_autocmds(
        "BufEnter",
        { group = "rooter", modeline = false }
      )
    end,
  },
  {
    "nvim-tree.lua",
    optional = true,
    dependencies = { "vim-rooter" },
  },
  {
    "neo-tree.nvim",
    optional = true,
    dependencies = { "vim-rooter" },
  },
  {
    "nvim-lint",
    optional = true,
    dependencies = { "vim-rooter" },
  },
}
