return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "ahmedkhalf/project.nvim",
    "williamboman/mason.nvim",
  },
  keys = {
    {
      "<leader>cl",
      function() require("lint").try_lint() end,
      desc = "Lint",
    },
  },
  config = function()
    require("lint").linters_by_ft = {
      javascript      = { "eslint_d" },
      typescript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte          = { "eslint_d" },
    }

    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      -- "InsertLeave",
      -- "TextChanged",
    }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end
      })

    require("lint").try_lint()
  end
}
