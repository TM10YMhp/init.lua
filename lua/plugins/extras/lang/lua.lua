return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "lua", "luadoc" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "lua_ls" } },
  },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "SereneNvim", words = { "SereneNvim" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  -- {
  --   "nvim-cmp",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, {
  --       name = "lazydev",
  --       max_item_count = 40,
  --       group_index = 0,
  --     })
  --   end,
  -- },
  {
    "blink.cmp",
    optional = true,
    opts = {
      sources = {
        -- default = { "lazydev" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
