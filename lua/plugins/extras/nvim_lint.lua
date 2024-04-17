local enabled_lint = true
-- stylua: ignore
local linters_by_ft = {
  javascript      = { "eslint_d" },
  typescript      = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte          = { "eslint_d" },
}

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
      "<cmd>lua require('lint').try_lint()<cr>",
      desc = "Lint",
    },
    {
      "<leader>tl",
      function()
        if enabled_lint then
          require("lint").linters_by_ft = {}
          vim.diagnostic.reset()
          require("tm10ymhp.utils").info("Lint: Disabled")
        else
          require("lint").linters_by_ft = linters_by_ft
          -- vim.diagnostic.reset()
          require("lint").try_lint()
          require("tm10ymhp.utils").info("Lint: Enabled")
        end
        enabled_lint = not enabled_lint
      end,
      desc = "Toggle Lint",
    },
  },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
    linters_by_ft = linters_by_ft,
  },
  config = function(_, opts)
    local lint = require("lint")

    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })

    lint.try_lint()
  end,
}
