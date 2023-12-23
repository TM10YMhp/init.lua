return {
  {
    "echasnovski/mini.jump2d",
    keys = {
      {
        "<cr>",
        "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        mode = { "n", "x" },
        desc = "Start 2d jumping",
      }
    },
    opts = {
      mappings = { start_jumping = "" }
    },
  },
  {
    "echasnovski/mini.jump",
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = 'Jump forward' },
      { "F", mode = { "n", "x", "o" }, desc = 'Jump backward' },
      { "t", mode = { "n", "x", "o" }, desc = 'Jump forward till' },
      { "T", mode = { "n", "x", "o" }, desc = 'Jump backward till' },
    },
    opts = { delay = { highlight = 0 } }
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      {
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics"
      },
      {
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics"
      },
    },
    opts = {
      height = 15,
      icons = false,
      padding = false,
      fold_open = "-",
      fold_closed = "+",
      indent_lines = false,
      use_diagnostic_signs = true,
      auto_preview = false,
      auto_jump = {},
    }
  },
  {
    "echasnovski/mini.trailspace",
    event = "VeryLazy",
    keys = {
      {
        '<leader>ct',
        function()
          MiniTrailspace.trim()
          MiniTrailspace.trim_last_lines()
        end,
        desc = "Trim All"
      }
    },
    config = function()
      require('mini.trailspace').setup()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'lazy',
        callback = function(data)
          vim.b[data.buf].minitrailspace_disable = true
          vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
        end,
      })
    end
  }
}
