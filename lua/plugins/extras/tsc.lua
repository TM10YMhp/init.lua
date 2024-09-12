return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  opts = {
    flags = {
      watch = true,
    },
    -- NOTE: `watch` is not compatible with `build`
    -- flags = "--build --noEmit",
    use_diagnostics = true,
  },
}
