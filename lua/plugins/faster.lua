vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            -- TODO: size of bigfile should be configurable in mb
            and vim.fn.getfsize(path) > 896 * 1024 -- 896kb
            and "bigfile"
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "bigfile" },
  desc = "Bigfile",
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.foldenable = false
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
  end,
})

return {
  "pteroctopus/faster.nvim",
  ft = "bigfile",
  keys = { { "@", desc = "execute_macro()" } },
  opts = {
    behaviours = {
      bigfile = {
        features_disabled = {
          "illuminate",
          "matchparen",
          "lsp",
          -- "treesitter",
          "indent_blankline",
          "vimopts",
          "syntax",
          -- "filetype",
        },
        filesize = 1,
      },
    },
  },
}
