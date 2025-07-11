return {
  "andymass/vim-matchup",
  event = "VeryLazy",
  opts = {
    matchparen = {
      enabled = false,
      offscreen = { method = "popup" },
    },
    treesitter = {
      enable_quotes = true,
    },
  },
  config = function(_, opts)
    require("match-up").setup(opts)

    vim.api.nvim_exec_autocmds(
      "FileType",
      { group = "matchup_filetype", modeline = false }
    )
  end,
}
