return {
  { import = "plugins.extras.lang.typescript" },
  { import = "plugins.extras.lang.css" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "astro" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
      },
    },
  },
  {
    "Wansmer/treesj",
    optional = true,
    opts = function(_, opts)
      local lang_utils = require("treesj.langs.utils")

      return vim.tbl_deep_extend("force", opts, {
        langs = {
          astro = {
            start_tag = lang_utils.set_default_preset({
              both = {
                omit = { "tag_name" },
              },
            }),
            self_closing_tag = lang_utils.set_default_preset({
              both = {
                omit = { "tag_name" },
                no_format_with = {},
              },
            }),
            element = lang_utils.set_default_preset({
              join = {
                space_separator = false,
              },
            }),
          },
        },
      })
    end,
  },
}
