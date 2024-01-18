vim.filetype.add({
  extension = {
    http = "http"
  }
})

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      result_split_horizontal = true,
      result = {
        show_curl_command = true,
      }
    },
    keys = {
      {
        '<leader>rr',
        "<cmd>lua require('rest-nvim').run()<cr>",
        desc = "RestNvim Run"
      },
      {
        '<leader>rl',
        "<cmd>lua require('rest-nvim').last()<cr>",
        desc = "RestNvim Last"
      },
      {
        '<leader>rp',
        "<cmd>lua require('rest-nvim').run(true)<cr>",
        desc = "RestNvim Preview"
      },
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        "http",
        "html",
        "json",
      })
    end
  }
}
