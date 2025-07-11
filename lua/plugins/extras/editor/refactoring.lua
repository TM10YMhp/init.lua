return {
  "ThePrimeagen/refactoring.nvim",
  cmd = "Refactor",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>rf",
      ":Refactor extract ",
      mode = "v",
      desc = "Extract Function",
    },
    {
      "<leader>rF",
      ":Refactor extract_to_file ",
      mode = "v",
      desc = "Extract Function To File",
    },
    {
      "<leader>rv",
      ":Refactor extract_var ",
      mode = "v",
      desc = "Extract Variable",
    },
    {
      "<leader>ri",
      ":Refactor inline_var",
      mode = { "n", "v" },
      desc = "Inline Variable",
    },
    {
      "<leader>rI",
      ":Refactor inline_function",
      desc = "Inline Function",
    },
    {
      "<leader>rb",
      ":Refactor extract_block",
      desc = "Extract Block",
    },
    {
      "<leader>rB",
      ":Refactor extract_block_to_file",
      desc = "Extract Block To File",
    },
    {
      "<leader>rP",
      function() require("refactoring").debug.printf({ below = false }) end,
      desc = "Debug Print",
    },
    {
      "<leader>rp",
      function() require("refactoring").debug.print_var({ normal = true }) end,
      mode = { "n", "v" },
      desc = "Debug Print Variable",
    },
    {
      "<leader>rc",
      function() require("refactoring").debug.cleanup({}) end,
      desc = "Debug Cleanup",
    },
  },
  opts = {
    printf_statements = {},
    print_var_statements = {},
    -- show_success_message = true,
  },
}
