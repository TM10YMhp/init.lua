return {
  {
    "Jezda1337/nvim-html-css",
    opts = {
      -- enable_on = {
      --   "html",
      --   "htmldjango",
      --   "tsx",
      --   "jsx",
      --   "erb",
      --   "svelte",
      --   "vue",
      --   "blade",
      --   "php",
      --   "templ",
      --   "astro",
      -- },
      handlers = {
        -- HACK: disable all handlers
        definition = { bind = "<nop>" },
        hover = { bind = "<nop>" },
      },
      style_sheets = {
        "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
        "https://cdnjs.cloudflare.com/ajax/libs/bulma/1.0.3/css/bulma.min.css",
        -- not work
        -- "https://www.nerdfonts.com/assets/css/webfont.css",
      },
    },
  },
  {
    "blink.cmp",
    optional = true,
    dependencies = { "nvim-html-css" },
    opts = {
      sources = {
        default = { "html-css" },
        providers = {
          ["html-css"] = {
            name = "html-css",
            module = "blink.compat.source",
          },
        },
      },
    },
  },
}
