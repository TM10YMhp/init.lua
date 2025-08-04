---@class serenenvim.util.heirline
local M = {}

--- An `init` function to build multiple update events which is not supported yet by Heirline's update field
---@param opts AstroUIUpdateEvents an array like table of autocmd events as either just a string or a table with custom patterns and callbacks. TODO: UPDATE TYPE
---@return function # The Heirline init function
-- @usage local heirline_component = { init = require("astroui.status").init.update_events { "BufEnter", { "User", pattern = "LspProgressUpdate" } } }
M.update_events = function(opts)
  -- TODO: remove check after dropping support for Neovim v0.9
  if not (vim.islist or vim.islist)(opts) then opts = { opts } end

  return function(self)
    if not rawget(self, "once") then
      local function clear_cache() self._win_cache = nil end
      for _, event in ipairs(opts) do
        local event_opts = { callback = clear_cache }
        if type(event) == "table" then
          event_opts.pattern = event.pattern
          if event.callback then
            local callback = event.callback
            event_opts.callback = function(args)
              clear_cache()
              callback(self, args)
            end
          end
          event = event[1]
        end
        vim.api.nvim_create_autocmd(event, event_opts)
      end
      self.once = true
    end
  end
end

M.absolute_path = {
  init = function(self)
    local data = ""

    if vim.api.nvim_get_option_value("buftype", {}) == "" then
      data = vim.fn.expand("%:~:.") or "[No Name]"
    else
      data = vim.fn.expand("%:t")
    end

    if data == "" then data = "[No Name]" end

    local folder = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    if folder ~= "" and data:sub(1, 1) ~= "~" then
      data = folder .. "/" .. data
    end

    -- self.data = "> " .. vim.fn.fnamemodify(data, ":.")
    self.data = vim.fn.fnamemodify(data, ":.")
  end,
  provider = function(self) return self.data end,
  update = { "BufLeave", "WinClosed" },
}

-- strings not respect update
M.git_branch = {
  provider = function()
    return vim.g.gitsigns_head and vim.g.gitsigns_head .. " " or ""
  end,
  update = {
    "User",
    pattern = { "GitSignsUpdate", "GitSignsChanged" },
    callback = function() vim.schedule(vim.cmd.redrawstatus) end,
  },
}

M.git_diff = {
  provider = function(self)
    local status = (vim.b[self and self.bufnr or 0].gitsigns_status or ""):gsub(
      "%s+",
      ""
    )
    return status ~= "" and status .. " " or ""
  end,
  update = {
    "User",
    pattern = { "GitSignsUpdate", "GitSignsChanged" },
    callback = function() vim.schedule(vim.cmd.redrawstatus) end,
  },
  -- https://github.com/rebelot/heirline.nvim/issues/71#issuecomment-1272940354
  init = function(self)
    if not rawget(self, "once") then
      local clear_cache = function() self._win_cache = nil end
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = clear_cache,
      })
      self.once = true
    end
  end,
}

M.filesize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { "b", "k", "M", "G", "T", "P", "E" }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize == 0 then return "" end
    if fsize < 1024 then return " " .. fsize .. suffix[1] end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return " "
      .. string.format("%.2f%s", fsize / math.pow(1024, i), suffix[i + 1])
  end,
  update = { "BufWritePost", "BufEnter" },
}

M.workspace_diagnostic = {
  provider = function()
    local res = {
      [vim.diagnostic.severity.ERROR] = 0,
      [vim.diagnostic.severity.WARN] = 0,
      [vim.diagnostic.severity.INFO] = 0,
      [vim.diagnostic.severity.HINT] = 0,
    }
    for _, v in ipairs(vim.diagnostic.get()) do
      res[v.severity] = res[v.severity] + 1
    end

    local errors = res[1]
    local warnings = res[2]
    local infos = res[3]
    local hints = res[4]

    local r = (errors > 0 and "E" .. errors or "")
      .. (warnings > 0 and "W" .. warnings or "")
      .. (infos > 0 and "I" .. infos or "")
      .. (hints > 0 and "H" .. hints or "")
    return r ~= "" and " " .. r or ""
  end,
  update = {
    "DiagnosticChanged",
    callback = function() vim.schedule(vim.cmd.redrawstatus) end,
  },
}

M.lsp_active = {
  provider = function()
    local clients = #vim.lsp.get_clients()
    local buf_clients =
      #vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

    if clients > 0 then return "[" .. buf_clients .. "|" .. clients .. "]" end
  end,
  update = { "LspAttach", "LspDetach", "BufEnter" },
}

M.file_encoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
    return enc ~= "utf-8" and " " .. enc
  end,
}

M.file_format = {
  provider = function()
    local fmt = vim.bo.fileformat
    return fmt == "unix" and "" or " " .. fmt
  end,
}

M.file_type = {
  provider = function() return vim.bo.filetype end,
}

return M
