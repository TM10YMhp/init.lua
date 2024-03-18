return {
  "pteroctopus/faster.nvim",
  event = "BufReadPre",
  opts = {
    behaviours = {
      bigfile = {
        features_disabled = {
          "custom_feature",
          "illuminate",
          "matchparen",
          "lsp",
          "treesitter",
          "indent_blankline",
          "vimopts",
          "syntax",
          "filetype",
        },
        filetype = 1,
      },
    },
    features = {
      custom_feature = {
        on = true,
        defer = false,
        disable = function()
          vim.opt_local.cursorline = false
          vim.opt_local.foldenable = false
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.number = false
          vim.opt_local.signcolumn = "no"
          vim.b.isbigfile = true

          vim.api.nvim_create_autocmd({ "BufEnter" }, {
            desc = "Restore events",
            callback = function()
              if not vim.b.isbigfile then
                vim.opt.eventignore = ""
              else
                vim.opt.eventignore = {
                  "CursorHold",
                  "CursorHoldI",
                  "CursorMoved",
                  "CursorMovedI",
                  "WinScrolled",
                  "FileType",
                  "TextYankPost",
                }
              end
            end,
          })
        end,
      },
    },
  },
}
