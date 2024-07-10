return {
  "akinsho/bufferline.nvim",
  event = vim.fn.argc(-1) == 0 and "BufAdd" or "VeryLazy",
  keys = {
    {
      "<leader>bP",
      "<Cmd>BufferLineGroupClose ungrouped<CR>",
      desc = "Delete non-pinned buffers",
    },
    {
      "<leader>bo",
      "<Cmd>BufferLineCloseOthers<CR>",
      desc = "Delete other buffers",
    },
    {
      "<leader>br",
      "<Cmd>BufferLineCloseRight<CR>",
      desc = "Delete buffers to the right",
    },
    {
      "<leader>bl",
      "<Cmd>BufferLineCloseLeft<CR>",
      desc = "Delete buffers to the left",
    },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  opts = function()
    local bufferline = require("bufferline")
    return {
      options = {
        style_preset = {
          bufferline.style_preset.no_bold,
          bufferline.style_preset.no_italic,
        },
        indicator = { style = "none" },
        buffer_close_icon = "x",
        modified_icon = "*",
        close_icon = "x",
        left_trunc_marker = "<",
        right_trunc_marker = ">",
        truncate_names = false,
        tab_size = 0,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(_, _, diagnostics_dict)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and "E "
              or (e == "warning" and "W " or "H ")
            s = s .. n .. sym
          end
          return vim.trim(s)
        end,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_duplicate_prefix = true,
        max_prefix_length = 100,
        move_wraps_at_ends = false,
        separator_style = { "", "" },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = { enabled = false },
      },
    }
  end,
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
