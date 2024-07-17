return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = SereneNvim.lazy_init and "BufAdd" or "VeryLazy",
  keys = {
    {
      "zR",
      "<cmd>lua require('ufo').openAllFolds()<cr>",
      desc = "Open all folds",
    },
    {
      "zM",
      "<cmd>lua require('ufo').closeAllFolds()<cr>",
      desc = "Close all folds",
    },
    {
      "zr",
      "<cmd>lua require('ufo').openFoldsExceptKinds()<cr>",
      desc = "Open folds except kinds",
    },
    {
      "zm",
      "<cmd>lua require('ufo').closeFoldsWith()<cr>",
      desc = "Close folds with",
    },
    {
      "zK",
      "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<cr>",
      desc = "Peek folds under cursor (Preview)",
    },
  },
  opts = function()
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" ... (%d) "):format(endLnum - lnum)
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
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "UfoFoldedEllipsis" })
      return newVirtText
    end

    return {
      open_fold_hl_timeout = 0,
      fold_virt_text_handler = handler,
      preview = {
        win_config = {
          border = "single",
          -- border = { "", "─", "", "", "", "─", "", "" },
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          scrollE = "<Down>",
          scrollY = "<Up>",
          jumpTop = "gg",
          jumpBot = "G",
        },
      },
    }
  end,
  config = function(_, opts)
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    require("ufo").setup(opts)

    local ft_ignore = {
      "nvcheatsheet",
      "neo-tree",
      "dashboard",
      "dbui",
      "bigfile",
    }

    for _, bufnr in ipairs(vim.fn.tabpagebuflist(vim.fn.tabpagenr("$"))) do
      if vim.list_contains(ft_ignore, vim.bo[bufnr].filetype) then
        require("ufo").detach(bufnr)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft_ignore,
      callback = function()
        vim.schedule(function()
          require("ufo").detach()
          vim.opt_local.foldenable = false
          vim.opt_local.foldcolumn = "0"
        end)
      end,
    })
  end,
}
