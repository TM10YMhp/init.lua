local M = {}

M.setup = function(opts)
  local default_opts = {
    size = 1.5 * 1024 * 1024, -- 1.5MB
    line_length = 1000,
  }

  opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  vim.filetype.add({
    pattern = {
      [".*"] = {
        function(path, buf)
          if not path or not buf or vim.bo[buf].filetype == "bigfile" then
            return
          end
          if path ~= vim.fs.normalize(vim.api.nvim_buf_get_name(buf)) then
            return
          end
          local size = vim.fn.getfsize(path)
          if size <= 0 then return end
          if size > opts.size then return "bigfile" end
          local lines = vim.api.nvim_buf_line_count(buf)
          return (size - lines) / lines > opts.line_length and "bigfile" or nil
        end,
      },
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "bigfile",
    callback = function()
      vim.opt_local.wrap = false
      vim.opt_local.cursorline = false
      vim.opt_local.foldenable = false
      vim.opt_local.foldcolumn = "0"
      vim.opt_local.number = false
      vim.opt_local.signcolumn = "no"

      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.undolevels = -1
      vim.opt_local.undoreload = 0
      vim.opt_local.list = false

      vim.opt_local.linebreak = false
      vim.opt_local.breakindent = false
    end,
  })
end

return M
