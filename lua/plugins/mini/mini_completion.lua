return {
  -- only used for signature help
  "echasnovski/mini.completion",
  event = "LspAttach",
  opts = {
    delay = { completion = 10 ^ 7, info = 10 ^ 7 },
    window = {
      signature = { border = "single" },
    },
    lsp_completion = {
      auto_setup = false,
    },
    mappings = {
      force_twostep = "",
      force_fallback = "",
    },
    set_vim_settings = false,
  },
}
