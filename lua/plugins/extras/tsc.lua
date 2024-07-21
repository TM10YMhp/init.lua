return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  opts = {
    flags = { watch = true },
    use_diagnostics = true,
  },
  config = function()
    SereneNvim.hacks.tsc()
    require("tsc").setup()
  end,
}
