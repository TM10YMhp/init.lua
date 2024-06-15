local M = {}

M.absolute_path = function()
  return {
    init = function(self)
      local data = ""

      if vim.api.nvim_get_option_value("buftype", {}) == "" then
        data = vim.fn.expand("%:~:.") or "[No Name]"
      else
        data = vim.fn.expand("%:t")
      end

      if data == "" then
        data = "[No Name]"
      end

      self.data = "> " .. data
    end,
    provider = function(self)
      return self.data
    end,
    update = { "BufEnter" },
  }
end

return M
