return {
  "hat0uma/csvview.nvim",
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    view = {
      spacing = 0,
      header_lnum = true,
    },
  },
}
