-- FIX: WIP Experimental
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        dependencies = {
          "Bilal2453/luvit-meta", -- optional `vim.uv` typings
        },
        opts = {
          library = {
            -- Only load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
    },
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
