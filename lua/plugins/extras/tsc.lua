return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  config = function()
    require("tsc.utils").find_tsconfigs = function()
      local tsconfig = vim.fn.findfile("tsconfig.json", ".;")
      local jsconfig = vim.fn.findfile("jsconfig.json", ".;")

      if tsconfig ~= "" then
        return { tsconfig }
      end

      if jsconfig ~= "" then
        return { jsconfig }
      end

      return {}
    end

    require("tsc").setup({
      bin_path = "tsc.CMD",
      flags = { watch = true },
    })
  end,
}
