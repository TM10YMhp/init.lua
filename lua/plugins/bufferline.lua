return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "echasnovski/mini.bufremove",
      keys = {
        {
          "<leader>bd",
          function()
            local bd = require("mini.bufremove").delete
            if vim.bo.modified then
              local choice = vim.fn.confirm(
                ("Save changes to %q?"):format(vim.fn.bufname()),
                "&Yes\n&No\n&Cancel"
              )
              if choice == 1 then -- Yes
                vim.cmd.write()
                bd(0)
              elseif choice == 2 then -- No
                bd(0, true)
              end
            else
              bd(0)
            end
          end,
          desc = "Delete Buffer New",
        },
        {
          "<leader>bD",
          function() require("mini.bufremove").delete(0, true) end,
          desc = "Delete Buffer (Force) New",
        },
      },
    },
    keys = {
      {
        "<leader>bp",
        "<Cmd>BufferLineTogglePin<CR>",
        desc = "Toggle pin",
      },
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
      {
        "[b",
        "<cmd>BufferLineCyclePrev<cr>",
        desc = "Prev buffer",
      },
      {
        "]b",
        "<cmd>BufferLineCycleNext<cr>",
        desc = "Next buffer",
      },
    },
    opts = function()
      local bufferline = require('bufferline')

      return {
        options = {
          style_preset = {
            bufferline.style_preset.no_bold,
            bufferline.style_preset.no_italic
          },
          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          right_mouse_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          indicator = { style = "none" },
          buffer_close_icon = "x",
          modified_icon = '*',
          close_icon = "x",
          left_trunc_marker = '<',
          right_trunc_marker = '>',
          truncate_names = false,
          tab_size = 0,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(_, _, diagnostics_dict)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and "E "
              or (e == "warning" and "W " or "H " )
              s = s .. n .. sym
            end
            return vim.trim(s)
          end,
          show_buffer_icons = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          move_wraps_at_ends = false,
          separator_style = { "", "" },
          always_show_bufferline = true,
          hover = { enabled = false },
        },
      }
    end,
  }
}
