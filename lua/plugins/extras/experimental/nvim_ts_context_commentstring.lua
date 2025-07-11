return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  keys = {
    {
      "gc",
      function() return require("vim._comment").operator() end,
      expr = true,
      mode = { "n", "x" },
      desc = "Toggle comment",
    },
    {
      "gcc",
      function() return require("vim._comment").operator() .. "_" end,
      expr = true,
      desc = "Toggle comment line",
    },
    {
      "gc",
      function() require("vim._comment").textobject() end,
      mode = { "o" },
      desc = "Comment textobject",
    },
  },
  init = function() vim.g.skip_ts_context_commentstring_module = 1 end,
  opts = {
    enable_autocmd = false,
  },
  config = function(_, opts)
    require("ts_context_commentstring").setup(opts)

    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring"
          and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
    end
  end,
}
