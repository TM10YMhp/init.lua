---@class serenenvim.util.heirline
local M = {}

--- An `init` function to build multiple update events which is not supported yet by Heirline's update field
---@param opts AstroUIUpdateEvents an array like table of autocmd events as either just a string or a table with custom patterns and callbacks. TODO: UPDATE TYPE
---@return function # The Heirline init function
-- @usage local heirline_component = { init = require("astroui.status").init.update_events { "BufEnter", { "User", pattern = "LspProgressUpdate" } } }
function M.update_events(opts)
  -- TODO: remove check after dropping support for Neovim v0.9
  if not (vim.islist or vim.tbl_islist)(opts) then
    opts = { opts }
  end

  return function(self)
    if not rawget(self, "once") then
      local function clear_cache()
        self._win_cache = nil
      end
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

    if data == "" then
      data = "[No Name]"
    end

    self.data = "> " .. data
  end,
  provider = function(self)
    return self.data
  end,
  update = { "BufLeave" },
}

return M
