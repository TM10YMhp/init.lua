return {
  { import = "plugins.extras.lang.typescript" },
  { import = "plugins.extras.lang.css" },
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "astro" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "astro" } },
  },
  {
    "treesj",
    optional = true,
    opts = function(_, opts)
      local lang_utils = require("treesj.langs.utils")

      opts.langs = vim.tbl_deep_extend("force", opts.langs or {}, {
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
      })

      return opts
    end,
  },
}
