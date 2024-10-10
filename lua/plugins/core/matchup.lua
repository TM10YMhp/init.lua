return {
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.g.matchup_matchparen_enabled = 0

      vim.api.nvim_exec_autocmds(
        "FileType",
        { group = "matchup_filetype", modeline = false }
      )
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      matchup = {
        enable = true,
        enable_quotes = true,
      },
    },
  },
}
