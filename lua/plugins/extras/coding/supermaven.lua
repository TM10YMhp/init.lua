return {
  {
    "supermaven-inc/supermaven-nvim",
    cmd = {
      "SupermavenUseFree",
      "SupermavenUsePro",
    },
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
      require("supermaven-nvim.completion_preview").suggestion_group = "NonText"
    end,
  },
  {
    "blink.cmp",
    optional = true,
    dependencies = { "supermaven-nvim" },
    opts = {
      keymap = {
        ["<C-s>"] = {
          function(cmp) cmp.show({ providers = { "supermaven" } }) end,
        },
      },
      sources = {
        default = { "supermaven" },
        providers = {
          supermaven = {
            name = "supermaven",
            module = "blink.compat.source",
            async = true,
            kind = "Supermaven",
            score_offset = 100,
          },
        },
      },
    },
  },
}
