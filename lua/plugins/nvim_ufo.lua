return {
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = function()
      local builtin = require("statuscol.builtin")

      return {
        -- relculright = true,
        segments = {
          { text = { builtin.foldfunc } },
          { text = { "%s" } },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
          },
        }
      }
    end
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "VeryLazy",
    keys = {
      {
        'zR',
        "<cmd>lua require('ufo').openAllFolds()<cr>",
        desc = "Open all folds",
      },
      {
        'zM',
        "<cmd>lua require('ufo').closeAllFolds()<cr>",
        desc = "Close all folds",
      },
      {
        'zr',
        "<cmd>lua require('ufo').openFoldsExceptKinds()<cr>",
        desc = "Open folds except kinds",
      },
      {
        'zm',
        "<cmd>lua require('ufo').closeFoldsWith()<cr>",
        desc = "Close folds with",
      },
      {
        'zK',
        "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<cr>",
        desc = "Peek folds under cursor",
      },
    },
    opts = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' ... (%d) '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix})
        return newVirtText
      end

      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      return {
        open_fold_hl_timeout = 0,
        -- provider_selector = function(bufnr, filetype, buftype)
        --   return {'treesitter', 'indent'}
        -- end,
        fold_virt_text_handler = handler,
        preview = {
          win_config = {
            border = "single",
            -- border = { "", "─", "", "", "", "─", "", "" },
            winblend = 0,
          },
          mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            scrollE = '<Down>',
            scrollY = '<Up>',
            jumpTop = 'gg',
            jumpBot = 'G'
          }
        }
      }
    end,
  }
}
