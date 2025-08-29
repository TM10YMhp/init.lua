return {
  "nvim-mini/mini.files",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ef",
      function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
        if vim.fn.filereadable(buf_name) == 1 then
          -- Pass the full file path to highlight the file
          require("mini.files").open(buf_name, true)
        elseif vim.fn.isdirectory(dir_name) == 1 then
          -- If the directory exists but the file doesn't, open the directory
          require("mini.files").open(dir_name, true)
        else
          -- If neither exists, fallback to the current working directory
          require("mini.files").open(vim.uv.cwd(), true)
        end
      end,
      desc = "Open mini.files (Directory of Current File or CWD if not exists)",
    },
    {
      "<leader>eF",
      function() require("mini.files").open(vim.uv.cwd(), true) end,
      desc = "Open mini.files (cwd)",
    },
  },
  opts = {
    mappings = {
      close = "<Esc>",
      -- Use this if you want to open several files
      go_in = "l",
      -- This opens the file, but quits out of mini.files (default L)
      go_in_plus = "<CR>",
      -- I swapped the following 2 (default go_out: h)
      -- go_out_plus: when you go out, it shows you only 1 item to the right
      -- go_out: shows you all the items to the right
      go_out = "H",
      go_out_plus = "<BS>",
      -- Default <BS>
      reset = "-",
      -- Default @
      reveal_cwd = ".",
      show_help = "g?",
      -- Default =
      synchronize = "=",
      trim_left = "<",
      trim_right = ">",
    },
    options = {
      use_as_default_explorer = false,
    },
    windows = {
      preview = true,
      width_focus = 40,
      width_preview = 25,
    },
  },
}
