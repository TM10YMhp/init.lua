return {
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
    init = function()
      -- TODO: remove this and use dotenv.vim
      vim.g.dbs = {
        {
          name = "root@localhost:3306",
          url = "mysql://root@localhost:3306",
        },
        {
          name = "root@localhost:3307",
          url = "mysql://root@localhost:3307",
        },
      }

      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      -- vim.g.db_ui_use_nvim_notify = true
      vim.g.db_ui_execute_on_save = false
      vim.g.db_ui_winwidth = 33

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
  },
}
