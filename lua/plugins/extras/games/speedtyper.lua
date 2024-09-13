return {
  "NStefan002/speedtyper.nvim",
  cmd = "Speedtyper",
  keys = {
    {
      "<leader>vf",
      "<cmd>Speedtyper<CR>",
      desc = "Type Speedtyper",
    },
  },
  opts = {
    window = {
      border = "single",
      close_with = "q",
    },
    highlights = {
      falling_word_typed = "DiffAdd",
    },
  },
  config = function(_, opts)
    local mod = require("speedtyper.window")
    local open_float = mod.open_float
    mod.open_float = function(_opts)
      open_float(_opts)

      vim.api.nvim_set_option_value("stc", "", { scope = "local" })
      vim.opt_local.scrolloff = 0
    end

    local mod2 = require("speedtyper.game_modes")
    local start_game = mod2.start_game
    mod2.start_game = function()
      start_game()

      local game_mode = mod2.game_mode
      if game_mode ~= "rain" then
        return
      end

      local buf = vim.api.nvim_get_current_buf()
      vim.keymap.set({ "n", "v", "i" }, "<CR>", "<nop>", { buffer = buf })
      vim.keymap.set({ "n", "v", "i" }, "<BS>", function()
        if vim.fn.getline(vim.fn.line(".")):len() == 0 then
          return
        end
        return "<BS>"
      end, { buffer = buf, expr = true })
    end

    require("speedtyper").setup(opts)
  end,
}
