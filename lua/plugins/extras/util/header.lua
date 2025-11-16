return {
  "attilarepka/header.nvim",
  cmd = { "AddLicenseGPL3", "AddLicenseWTFPL", "AddHeader" },
  keys = {
    { "<leader>ih", "<cmd>AddLicenseWTFPL<cr>", desc = "Insert Header" },
  },
  opts = {
    file_name = false,
    author = "T4PE",
    date_created = false,
    line_separator = "--------------",
    copyright_text = "Copyright 2025",
  },
  config = function(_, opts)
    require("header").setup(opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        local header = require("header")
        if header and header.update_date_modified then
          header.update_date_modified()
        else
          vim.notify_once(
            "header.update_date_modified is not available",
            vim.log.levels.WARN
          )
        end
      end,
      desc = "Update header's date modified",
    })
  end,
}
