return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local luasnip = require("luasnip")

    -- set this before configuring luasnip
    luasnip.filetype_extend("all", { "loremipsum" })
    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.setup()
  end,
}
