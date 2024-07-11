return {
  "alan-w-255/telescope-mru.nvim",
  dependencies = {
    "yegappan/mru",
    event = vim.fn.argc(-1) == 0 and "BufAdd" or "VeryLazy",
    config = function()
      vim.api.nvim_exec_autocmds(
        "BufRead",
        { group = "MRUAutoCmds", modeline = false }
      )
    end,
  },
  keys = {
    { "<leader>so", "<cmd>Telescope mru<cr>", desc = "MRU" },
  },
  config = function()
    require("telescope").load_extension("mru")
  end,
}