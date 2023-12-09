return {
  "rest-nvim/rest.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    vim.filetype.add({
      extension = {
        http = "http"
      }
    })
  end,
  config = function()
    require("rest-nvim").setup({
      result_split_horizontal = true,
      result = {
        show_curl_command = true,
      }
    })

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

    vim.keymap.set('n', '<leader>rr', function()
      if is_http() then
        require("rest-nvim").run()
      end
    end, { desc = "RestNvim Run" })
    vim.keymap.set('n', '<leader>rl', function()
      if is_http() then
        require("rest-nvim").last()
      end
    end, { desc = "RestNvim Last" })
    vim.keymap.set('n', '<leader>rp', function()
      if is_http() then
        require("rest-nvim").run(true)
      end
    end, { desc = "RestNvim Preview" })
  end
}
