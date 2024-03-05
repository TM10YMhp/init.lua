vim.filetype.add({
  extension = {
    http = "http",
  },
})

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      result_split_horizontal = true,
      result = {
        show_curl_command = true,
      },
    },
    keys = {
      {
        "<leader>rr",
        function()
          if require("tm10ymhp.utils").is_http() then
            require("rest-nvim").run()
          end
        end,
        desc = "RestNvim Run",
      },
      {
        "<leader>rl",
        function()
          if require("tm10ymhp.utils").is_http() then
            require("rest-nvim").last()
          end
        end,
        desc = "RestNvim Last",
      },
      {
        "<leader>rp",
        function()
          if require("tm10ymhp.utils").is_http() then
            require("rest-nvim").run(true)
          end
        end,
        desc = "RestNvim Preview",
      },
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)
    end,
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
    end,
  },
}
