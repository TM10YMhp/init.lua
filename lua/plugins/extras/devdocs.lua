return {
  "luckasRanarison/nvim-devdocs",
  cmd = { "DevdocsOpen", "DevdocsFetch", "DevdocsInstall", "DevdocsUpdate" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    telescope = {
      previewer = false,
    },
    float_win = {
      width = 90,
      height = 40,
      border = "single",
    },
    after_open = function(bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":bd<CR>", {})
    end,
  },
}
