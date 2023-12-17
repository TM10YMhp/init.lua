local is_http = function()
  if vim.bo.filetype ~= 'http' then
    require("tm10ymhp.utils").notify(
      'RestNvim is only supported for HTTP requests',
      vim.log.levels.ERROR
    )

    return false
  end

  return true
end

return {
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    vim.filetype.add({
      extension = {
        http = "http"
      }
    })
  end,
  opts = {
    result_split_horizontal = true,
    result = {
      show_curl_command = true,
    }
  },
  keys = {
    {
      '<leader>rr',
      function()
        if is_http() then require("rest-nvim").run() end
      end,
      desc = "RestNvim Run"
    },
    {
      '<leader>rl',
      function()
        if is_http() then require("rest-nvim").last() end
      end,
      desc = "RestNvim Last"
    },
    {
      '<leader>rp',
      function()
        if is_http() then require("rest-nvim").run(true) end
      end,
      desc = "RestNvim Preview"
    },
  },
  config = function(_, opts)
    require("rest-nvim").setup(opts)
  end
}
