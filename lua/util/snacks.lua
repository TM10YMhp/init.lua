---@class serenenvim.util.snacks
local M = {}

-- NOTE: https://github.com/Saghen/blink.cmp/commit/61636a2630acd4a0b5711f684509cb8b3e78941c
M.banned_messages = {
  "Validate documents",
  "Publish Diagnostics",
}

M.simple_lsp_progress = function()
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local spinner = {
        "=",
        "*",
        "-",
      }

      local msg = vim.lsp.status()

      if msg == "" then return end
      for _, banned in ipairs(M.banned_messages) do
        if msg:match(banned) then return end
      end

      vim.notify(msg, vim.log.levels.INFO, {
        id = "lsp_progress",
        title = "LSP Progress",
        opts = function(notif)
          notif.icon = ev.data.params.value.kind == "end" and ""
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

M.advanced_lsp_progress = function()
  ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
  local progress = vim.defaulttable()
  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
      if not client or type(value) ~= "table" then return end
      local p = progress[client.id]

      for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
          if
            value.message
            and value.title
            and value.message:match(value.title)
          then
            value.title = nil
          end
          p[i] = {
            token = ev.data.params.token,
            msg = ("[%d%%]%s%s"):format(
              value.kind == "end" and 100 or value.percentage or 100,
              value.title and (" %s"):format(value.title) or "",
              value.message and (" %s"):format(value.message) or ""
            ),
            done = value.kind == "end",
          }
          break
        end
      end

      local msg = {} ---@type string[]
      progress[client.id] = vim.tbl_filter(function(v)
        for _, banned in ipairs(M.banned_messages) do
          if v.msg:match(banned) then return end
        end

        return table.insert(msg, v.msg) or not v.done
      end, p)

      if next(msg) then
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
        })
      end
    end,
  })
end

return M
