vim.g.clipboard = "osc52"

return {
  { import = "plugins.extras.coding.blink" },
  { import = "plugins.extras.coding.colorful_menu" },
  { import = "plugins.extras.coding.luasnip" },

  { import = "plugins.extras.editor.conform" },
  { import = "plugins.extras.editor.fzf" },
  { import = "plugins.extras.editor.refactoring" },
  { import = "plugins.extras.editor.todo_comments" },
  { import = "plugins.extras.editor.nvim_highlight_colors" },

  { import = "plugins.extras.ui.cokeline" },
  { import = "plugins.extras.ui.heirline" },
  { import = "plugins.extras.ui.colorscheme" },
  { import = "plugins.extras.ui.nvim_bqf" },
  { import = "plugins.extras.ui.treesitter_context" },

  { import = "plugins.extras.util.emoji" },
  { import = "plugins.extras.util.mini_clue" },

  { import = "plugins.extras.lang.typst" },

  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      return {
        ensure_installed = vim.tbl_filter(
          function(x) return not vim.list_contains({ "tinymist" }, x) end,
          opts.ensure_installed
        ),
      }
    end,
  },

  {
    "chomosuke/typst-preview.nvim",
    optional = true,
    opts = {
      dependencies_bin = {
        tinymist = "tinymist",
        websocat = "websocat",
      },
    },
  },
}
