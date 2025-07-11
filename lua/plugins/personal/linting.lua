-- if vim.g.linter_enabled then
--   SereneNvim.on_lazy_ft("nvim-lint", {
--     "javascript",
--     "typescript",
--     "javascriptreact",
--     "typescriptreact",
--     "svelte",
--   })
-- end

return {
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "eslint" } },
  },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       sql = { "sqlfluff" },
  --     },
  --     linters = {
  --       sqlfluff = {
  --         args = { "lint", "--format=json", "--dialect=sqlite" },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     -- stylua: ignore
  --     linters_by_ft = {
  --       javascript      = { "eslint" },
  --       typescript      = { "eslint" },
  --       javascriptreact = { "eslint" },
  --       typescriptreact = { "eslint" },
  --       svelte          = { "eslint" },
  --     },
  --     linters = {
  --       eslint_d = {
  --         condition = function()
  --           return SereneNvim.exists_in_cwd({
  --             ".eslintrc",
  --             ".eslintrc.js",
  --             ".eslintrc.cjs",
  --             ".eslintrc.yaml",
  --             ".eslintrc.yml",
  --             ".eslintrc.json",
  --             "eslint.config.js",
  --             "eslint.config.mjs",
  --             "eslint.config.cjs",
  --             "eslint.config.ts",
  --             "eslint.config.mts",
  --             "eslint.config.cts",
  --           })
  --         end,
  --       },
  --     },
  --   },
  -- },
}
