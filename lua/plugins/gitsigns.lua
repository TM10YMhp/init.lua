return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    signs = SereneNvim.config.icons.gitsigns,
    signs_staged = SereneNvim.config.icons.gitsigns,
    signs_staged_enable = true,
    update_debounce = 1000,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 100,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
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
      "<leader>dd",
      "<cmd>Gitsigns diffthis<cr>",
      desc = "Diff This",
    },
    {
      "<leader>dD",
      "<cmd>Gitsigns diffthis ~<cr>",
      desc = "Diff This ~",
    },
    {
      "<leader>tg",
      "<cmd>Gitsigns toggle_signs<cr>",
      desc = "Toggle Git Signs",
    },
    {
      "<leader>tb",
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      desc = "Toggle Git Line Blame",
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
    {
      "<leader>hu",
      "<cmd>Gitsigns undo_stage_hunk<CR>",
      desc = "Undo Stage Hunk",
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
