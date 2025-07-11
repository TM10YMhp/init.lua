vim.g.linter_enabled = false

return {
  "mfussenegger/nvim-lint",
  init = function()
    SereneNvim.on_very_lazy(function()
      Snacks.toggle
        .new({
          name = "Linter",
          get = function() return vim.g.linter_enabled end,
          set = function(state)
            if state then
              SereneNvim.lint.enable()
            else
              SereneNvim.lint.disable()
            end
          end,
        })
        :map("<leader>ol")
    end)
  end,
  keys = {
    {
      "<leader>cl",
      "<cmd>lua SereneNvim.lint.debounce()<cr>",
      desc = "Lint",
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

    lint.linters_by_ft = opts.linters_by_ft

    vim.schedule(function() SereneNvim.lint.debounce() end)

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function() SereneNvim.lint.debounce() end,
    })
  end,
}
