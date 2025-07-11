return {
  -- {
  --   "nvim-ts-context-commentstring",
  --   optional = true,
  --   opts = {
  --     languages = {
  --       blade = "{{-- %s --}}",
  --     },
  --     not_nested_languages = {
  --       blade = true,
  --     },
  --   },
  -- },
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "blade", "php", "php_only" } },
  },
}
