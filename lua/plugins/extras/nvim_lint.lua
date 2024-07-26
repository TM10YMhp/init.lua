vim.g.linter_enabled = true

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
      "<cmd>lua SereneNvim.lint.debounce()<cr>",
      desc = "Lint",
    },
    {
      "<leader>tl",
      desc = "Toggle Lint",
    },
  },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" },
    linters_by_ft = {},
    linters = {},
  },
  config = function(_, opts)
    local lint = require("lint")
    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] =
          vim.tbl_deep_extend("force", lint.linters[name], linter)
      else
        lint.linters[name] = linter
      end
    end

    if vim.g.linter_enabled then
      lint.linters_by_ft = opts.linters_by_ft
      SereneNvim.lint.debounce()
    else
      lint.linters_by_ft = {}
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        SereneNvim.lint.debounce()
      end,
    })

    vim.keymap.set("n", "<leader>tl", function()
      if vim.g.linter_enabled then
        require("lint").linters_by_ft = {}
        vim.diagnostic.reset()
        SereneNvim.info("Lint: Disabled")
      else
        require("lint").linters_by_ft = opts.linters_by_ft
        SereneNvim.lint.debounce()
        SereneNvim.info("Lint: Enabled")
      end
      vim.g.linter_enabled = not vim.g.linter_enabled
    end, {
      desc = "Toggle Lint",
    })
  end,
}
