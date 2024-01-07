vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "svelte",
  },
  callback = function()
    vim.defer_fn(function()
      require("lazy").load({
        plugins = { "nvim-lint" },
      })
    end, 10)
  end,
})

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
  opts = {
    events = {
      "BufWritePost",
      "BufReadPost",
      "InsertLeave",
      "TextChanged",
    },
    linters_by_ft = {
      javascript      = { "eslint_d" },
      typescript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte          = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end
    })

    lint.try_lint()
  end
}
