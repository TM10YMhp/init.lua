return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  config = function()
    -- HACK: tsc doesn't work if tsconfig.json is jsconfig.json
    local utils = require("tsc.utils")

    local superclass_find_nearest_tsconfig = utils.find_nearest_tsconfig
    ---@diagnostic disable-next-line: duplicate-set-field
    function utils.find_nearest_tsconfig()
      superclass_find_nearest_tsconfig()

      local jsconfig = vim.fn.findfile("jsconfig.json", ".;")
      return jsconfig ~= "" and { jsconfig } or {}
    end

    ---@diagnostic disable-next-line: missing-fields
    require("tsc").setup({
      bin_path = "tsc.CMD",
      flags = { watch = true },
      use_diagnostics = true,
    })
  end,
}
