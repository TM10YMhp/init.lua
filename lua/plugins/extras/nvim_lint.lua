SereneNvim.on_lazy_ft("nvim-lint", {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "svelte",
})

return {
  "mfussenegger/nvim-lint",
  keys = {
    {
      "<leader>cl",
      "<cmd>lua require('lint').try_lint()<cr>",
      desc = "Lint",
    },
    {
      "<leader>tl",
      desc = "Toggle Lint",
    },
  },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
    -- stylua: ignore
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
      end,
    })

    local oldEslintConfig =
      vim.fn.split(vim.fn.glob(vim.uv.cwd() .. "/.eslintrc.*"))
    local newEslintConfig =
      vim.fn.split(vim.fn.glob(vim.uv.cwd() .. "/eslint.config.*"))

    local existsEslintConfig =
      not vim.tbl_isempty(vim.list_extend(oldEslintConfig, newEslintConfig))

    vim.g.linter_enabled = true

    if existsEslintConfig then
      lint.try_lint()
    else
      lint.linters_by_ft = {}
      SereneNvim.info("Lint: Not found eslint config")
      vim.g.linter_enabled = false
    end

    vim.keymap.set("n", "<leader>tl", function()
      if vim.g.linter_enabled then
        require("lint").linters_by_ft = {}
        vim.diagnostic.reset()
        SereneNvim.info("Lint: Disabled")
      else
        require("lint").linters_by_ft = opts.linters_by_ft
        require("lint").try_lint()
        SereneNvim.info("Lint: Enabled")
      end
      vim.g.linter_enabled = not vim.g.linter_enabled
    end, {
      desc = "Toggle Lint",
    })
  end,
}
