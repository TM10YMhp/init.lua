return {
  before_init = function()
    require("lazy").load({
      plugins = { "lazydev.nvim" },
    })
  end,
  settings = {
    Lua = {
      completion = {
        showWord = "Disable",
        workspaceWord = false,
        callSnippet = "Disable",
      },
      -- doc = {
      --   privateName = { "^_" },
      -- },
      hint = { enable = true },
      workspace = { checkThirdParty = "Disable" },
    },
  },
}
