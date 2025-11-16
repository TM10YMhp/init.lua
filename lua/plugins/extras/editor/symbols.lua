return {
  "oskarrrrrrr/symbols.nvim",
  keys = {
    {
      "<leader>ss",
      "<cmd>SymbolsToggle<cr>",
      desc = "Toggle Symbols",
    },
  },
  config = function()
    local r = require("symbols.recipes")
    require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
      sidebar = {
        open_direction = "right",
        auto_resize = { min_width = 30 },
        show_inline_details = true,
        chars = {
          folded = ">",
          unfolded = "v",
          guide_vert = "│",
          guide_middle_item = "├",
          guide_last_item = "└",
          hl = "NonText",
        },
        keymaps = {
          ["<Left>"] = "fold",
          ["<Right>"] = "unfold",
        },
      },
    })
  end,
}
