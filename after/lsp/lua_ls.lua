-- TODO: check emmylua_ls
-- - https://github.com/folke/lazydev.nvim/commit/c8e1d43
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
