return {
  {
    "alan-w-255/telescope-mru.nvim",
    dependencies = { "yegappan/mru" },
    keys = {
      { "<leader>so", "<cmd>Telescope mru<cr>", desc = "MRU" },
    },
    config = function()
      require("telescope").load_extension("mru")
    end,
  },
  {
    "yegappan/mru",
    event = SereneNvim.lazy_init and "BufAdd" or "VimLeavePre",
    config = function()
      vim.api.nvim_exec_autocmds(
        "BufRead",
        { group = "MRUAutoCmds", modeline = false }
      )
    end,
  },
}
