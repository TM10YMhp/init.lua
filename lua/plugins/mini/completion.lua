return {
  "echasnovski/mini.completion",
  event = "InsertEnter",
  opts = {
    delay = { completion = 1000 * 60 * 5 },
    window = {
      info = { border = "single" },
      signature = { border = "single" },
    },
    lsp_completion = {
      auto_setup = false,
    },
    mappings = {
      force_twostep = "",
      force_fallback = "",
    },
    set_vim_settings = false
  },
}
