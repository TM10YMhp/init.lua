return {
  {
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
  {
    "chrisgrieser/nvim-early-retirement",
    event = "BufLeave",
    opts = {
      retirementAgeMins = 15,
      notificationOnAutoClose = true,
      deleteBufferWhenFileDeleted = false,
      ignoreAltFile = false,
      minimumBufferNum = 1,
    }
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.bufremove" },
    keys = {
      {
        "<leader>bp",
        function()
          local state = require("bufferline.state")
          local commands = require("bufferline.commands")
          local _, element = commands.get_current_element_index(state)
          local utils = require("tm10ymhp.utils")
          if not element then
            utils.info("No buffer to toggle pin")
            return
          end

          local groups = require("bufferline.groups")
          if groups._is_pinned(element) then
            groups.remove_element("pinned", element)
            utils.info("Unpinned: " .. element.name)
            vim.b.ignore_early_retirement = false
          else
            groups.add_element("pinned", element)
            utils.info("Pinned: " .. element.name)
            vim.b.ignore_early_retirement = true
          end
          require("bufferline.ui").refresh()
        end,
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
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
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
          show_duplicate_prefix = true,
          max_prefix_length = 100,
          move_wraps_at_ends = false,
          separator_style = { "", "" },
          always_show_bufferline = true,
          hover = { enabled = false },
        },
      }
    end
  }
}
