return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  init = function()
    SereneNvim.on_very_lazy(function()
      Snacks.toggle
        .new({
          name = "Git Signs",
          get = function() return require("gitsigns.config").config.signcolumn end,
          set = function(state) require("gitsigns").toggle_signs(state) end,
        })
        :map("<leader>og")

      Snacks.toggle
        .new({
          name = "Git Line Blame",
          get = function()
            return require("gitsigns.config").config.current_line_blame
          end,
          set = function(state)
            require("gitsigns").toggle_current_line_blame(state)
          end,
        })
        :map("<leader>ob")
    end)
  end,
  opts = {
    signs = SereneNvim.config.icons.gitsigns,
    signs_staged = SereneNvim.config.icons.gitsigns,
    signs_staged_enable = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 250,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    update_debounce = 1000,
    preview_config = {
      border = "single",
      row = 1,
      col = 1,
      style = "minimal",
      relative = "cursor",
    },
  },
  keys = {
    {
      "<leader>gb",
      "<cmd>Gitsigns blame<cr>",
      desc = "Git Blame",
    },

    {
      "<leader>dd",
      "<cmd>Gitsigns diffthis vertical=true<cr>",
      desc = "Diff This",
    },
    {
      "<leader>dD",
      "<cmd>Gitsigns diffthis ~ vertical=true<cr>",
      desc = "Diff This ~",
    },
    {
      "ih",
      ":<C-U>Gitsigns select_hunk<CR>",
      mode = { "o", "x" },
      desc = "Select Hunk",
    },
    { "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Hunk" },
    { "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
    {
      "<leader>hb",
      "<cmd>lua require('gitsigns').blame_line({full=true})<cr>",
      desc = "Blame Line",
    },
    { "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
    {
      "<leader>hs",
      "<cmd>exe 'Gitsigns stage_hunk'|w<cr>",
      desc = "Stage Hunk",
    },
    {
      "<leader>hs",
      [[:<c-u>exe "'<,'>Gitsigns stage_hunk"|w<cr>]],
      mode = "x",
      desc = "Stage Hunk",
    },
    {
      "<leader>hr",
      ":Gitsigns reset_hunk<CR>",
      mode = { "n", "x" },
      desc = "Reset Hunk",
    },
    {
      "<leader>hS",
      "<cmd>exe 'Gitsigns stage_buffer'|w<cr>",
      desc = "Stage Buffer",
    },
    {
      "<leader>hR",
      "<cmd>exe 'Gitsigns reset_buffer'|Gitsigns refresh<cr>",
      desc = "Reset Buffer",
    },
  },
}
