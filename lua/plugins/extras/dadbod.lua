return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = { "tpope/vim-dadbod", cmd = "DB" },
  cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  keys = {
    { "<leader>db", "<cmd>DBUI<cr>", desc = "DBUI" },
  },
  init = function()
    vim.g.db_ui_win_position = "right"
    vim.g.db_ui_icons = {
      expanded = {
        db = "-",
        buffers = "-",
        saved_queries = "-",
        schemas = "-",
        schema = "-",
        tables = "-",
        table = "-",
      },
      collapsed = {
        db = "+",
        buffers = "+",
        saved_queries = "+",
        schemas = "+",
        schema = "+",
        tables = "+",
        table = "+",
      },
    }
    vim.g.db_ui_force_echo_notifications = 1
  end,
}
