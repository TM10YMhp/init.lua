if vim.g.linter_enabled then
  SereneNvim.on_lazy_ft("nvim-lint", {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "svelte",
  })
end

return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "eslint_d" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      -- stylua: ignore
      linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte          = { "eslint_d" },
      },
      linters = {
        eslint_d = {
          condition = function()
            return SereneNvim.exists_in_cwd({
              ".eslintrc",
              ".eslintrc.js",
              ".eslintrc.cjs",
              ".eslintrc.yaml",
              ".eslintrc.yml",
              ".eslintrc.json",
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts",
              "eslint.config.mts",
              "eslint.config.cts",
            })
          end,
        },
      },
    },
  },
}
