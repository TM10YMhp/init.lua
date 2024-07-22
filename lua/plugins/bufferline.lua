return {
  "akinsho/bufferline.nvim",
  event = SereneNvim.lazy_init and "BufAdd" or "VeryLazy",
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
  opts = {
    options = {
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
      diagnostics_indicator = function(_, _, diag)
        return vim.trim(
          (diag.error and "E" .. diag.error .. " " or "")
            .. (diag.warning and "W" .. diag.warning .. " " or "")
            .. (diag.hint and "H" .. diag.hint .. " " or "")
        )
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
  },
  config = function(_, opts)
    local bufferline = require("bufferline")

    opts = vim.tbl_deep_extend("force", opts, {
      options = {
        style_preset = {
          bufferline.style_preset.no_bold,
          bufferline.style_preset.no_italic,
        },
      },
    })

    bufferline.setup(opts)

    local ft_ignore = { "dashboard" }

    for _, bufnr in ipairs(vim.fn.tabpagebuflist(vim.fn.tabpagenr("$"))) do
      if vim.list_contains(ft_ignore, vim.bo[bufnr].filetype) then
        vim.opt.showtabline = 0
      end
    end
  end,
}
