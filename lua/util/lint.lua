local lint = require("lint")

---@class serenenvim.util.lint
local M = {}

function M.enable()
  vim.g.linter_enabled = true
  M.debounce()
end

function M.disable()
  vim.g.linter_enabled = false
  vim.diagnostic.reset()
end

function M.debounce(ms)
  ms = ms or 100
  local timer = vim.uv.new_timer()
  timer:start(ms, 0, function()
    timer:stop()
    vim.schedule_wrap(M.lint)()
  end)
end

function M.lint()
  if not vim.g.linter_enabled then
    return
  end

  local names = lint._resolve_linter_by_ft(vim.bo.filetype)
  names = vim.list_extend({}, names)

  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    if not linter then
      SereneNvim.warn("Linter not found: " .. name, { title = "nvim-lint" })
    end
    return linter
      and not (
        type(linter) == "table"
        and linter.condition
        and not linter.condition(ctx)
      )
  end, names)

  if #names > 0 then
    lint.try_lint(names)
  end
end

return M
