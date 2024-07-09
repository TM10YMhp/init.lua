return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      border = "single",
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>d"] = { name = "+diff" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>h"] = { name = "+hunk" },
      ["<leader>i"] = { name = "+insert" },
      ["<leader>k"] = { name = "+workspace" },
      ["<leader>l"] = { name = "+lsp/actions" },
      ["<leader>m"] = { name = "+harpoon" },
      ["<leader>o"] = { name = "+obsidian" },
      ["<leader>q"] = { name = "+delete/wipeout" },
      ["<leader>r"] = { name = "+rest" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>t"] = { name = "+toggle" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["<leader>z"] = { name = "+games" },
    })
  end,
}
