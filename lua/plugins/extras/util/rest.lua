SereneNvim.on_lazy_init(function()
  vim.filetype.add({
    extension = {
      http = "http",
    },
  })
end)

return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "rest-nvim/rest.nvim",
    tag = "v1.2.1", -- NOTE: wait until the project is resumed
    main = "rest-nvim",
    opts = {
      result_split_horizontal = true,
      result = {
        show_curl_command = true,
      },
    },
    keys = {
      {
        "<leader>Rr",
        "<cmd>lua require('rest-nvim').run()<cr>",
        desc = "RestNvim Run",
      },
      {
        "<leader>Rl",
        "<cmd>lua require('rest-nvim').last()<cr>",
        desc = "RestNvim Last",
      },
      {
        "<leader>Rp",
        "<cmd>lua require('rest-nvim').run(true)<cr>",
        desc = "RestNvim Preview",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      ensure_installed = {
        "http",
        "html",
        "json",
      },
    },
  },
}
