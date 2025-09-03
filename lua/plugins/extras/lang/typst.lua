return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "typst" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "tinymist" } },
  },
  {
    "chomosuke/typst-preview.nvim",
    keys = {
      {
        "<leader>up",
        function()
          local message = table.concat({
            '`typst-preview` is only available for filetype "typst"',
            'Current filetype is "' .. vim.bo.filetype .. '"',
          }, "\n")
          if vim.bo.filetype ~= "typst" then return SereneNvim.warn(message) end

          vim.cmd("TypstPreviewToggle")
        end,
        desc = "Toggle Typst Preview",
      },
    },
    opts = {
      follow_cursor = false,
      get_root = function(path_of_main_file)
        local root = os.getenv("TYPST_ROOT")
        if root then return root end
        local root_dir = vim.fs.dirname(
          vim.fs.find(
            { ".git", ".root" },
            { path = path_of_main_file, upward = true }
          )[1]
        )
        if root_dir then return root_dir end
        return vim.fn.fnamemodify(path_of_main_file, ":p:h")
      end,
    },
  },
}
