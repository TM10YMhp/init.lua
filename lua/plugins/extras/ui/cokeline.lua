return {
  "willothy/nvim-cokeline",
  event = "VeryLazy",
  keys = {
    { "<S-Tab>", "<Plug>(cokeline-focus-prev)", silent = true },
    { "<Tab>", "<Plug>(cokeline-focus-next)", silent = true },
  },
  opts = {
    tabs = {
      components = {
        {
          text = function(tab)
            return (tab.is_first and tab.is_last) and "" or " " .. tab.index
          end,
          highlight = function(tab)
            return tab.is_active and "TabLineSel" or "TabLine"
          end,
        },
      },
    },
    components = {
      {
        text = function(buffer) return " " .. buffer.devicon.icon end,
        highlight = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
      {
        text = function(buffer) return buffer.unique_prefix end,
        highlight = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
      {
        text = function(buffer) return buffer.filename end,
        highlight = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
      {
        text = function(buffer)
          local errors = buffer.diagnostics.errors
          local warnings = buffer.diagnostics.warnings
          local infos = buffer.diagnostics.infos
          local hints = buffer.diagnostics.hints

          local diagnostics = vim.trim(
            (errors > 0 and "E" .. errors or "")
              .. (warnings > 0 and "W" .. warnings or "")
              .. (infos > 0 and "I" .. infos or "")
              .. (hints > 0 and "H" .. hints or "")
          )

          return diagnostics:len() > 0 and " " .. diagnostics or ""
        end,
        highlight = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
      {
        text = function(buffer) return buffer.is_modified and " *" or "" end,
        highlight = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
      {
        text = " ",
        highlight = function(buffer)
          return buffer.is_focused and "TabLineSel" or "TabLine"
        end,
      },
    },
  },
  config = function(_, opts)
    require("cokeline").setup(opts)

    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function() vim.schedule(vim.cmd.redrawtabline) end,
    })
  end,
}
