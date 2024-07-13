return {
  -- optional `vim.uv` typings
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/lazydev.nvim" },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        max_item_count = 40,
        group_index = 0,
      })
    end,
  },
}
