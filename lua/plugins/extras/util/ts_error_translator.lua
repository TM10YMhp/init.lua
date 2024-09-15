return {
  { "dmmulroy/ts-error-translator.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = {
          on_new_config = function(new_config)
            require("ts-error-translator").setup()
          end,
        },
      },
    },
  },
}
