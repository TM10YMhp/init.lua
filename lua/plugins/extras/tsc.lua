return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  opts = {
    bin_path = vim.fn.exepath("tsc"),
    flags = { watch = true },
    use_diagnostics = true,
  },
}
