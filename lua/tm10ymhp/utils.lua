local M = {}

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param from string
---@param to string
function M.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 3000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

function M.is_http()
  if vim.bo.filetype ~= "http" then
    M.error(table.concat({
      'RestNvim is only available for filetype "http"',
      'current filetype: "' .. vim.bo.filetype .. '")',
    }, "\n"))
    return false
  end
  return true
end

function M.is_large_file(filepath)
  if
    -- vim.fn.strwidth(filepath) > 300 or
    -- vim.fn.getfsize(filepath) > 1024 * 1024 -- 1024kb
    -- vim.fn.getfsize(filepath) > 512 * 1024 -- 512kb
    vim.fn.getfsize(filepath) > 896 * 1024 -- 896kb
  then
    return true
  else
    return false
  end
end

function M.notify(msg, level, opts)
  local default_opts = { title = "Notification" }
  vim.notify(
    msg,
    level or vim.log.levels.INFO,
    vim.tbl_extend("force", default_opts, opts or {})
  )
end

function M.error(msg, opts)
  M.notify(msg, vim.log.levels.ERROR, opts or {})
end

function M.info(msg, opts)
  M.notify(msg, vim.log.levels.INFO, opts or {})
end

function M.warn(msg, opts)
  M.notify(msg, vim.log.levels.WARN, opts or {})
end

---@type {k:string, v:any}[]
M._maximized = nil
---@param state boolean?
function M.maximize(state)
  if state == (M._maximized ~= nil) then
    return
  end
  if M._maximized then
    for _, opt in ipairs(M._maximized) do
      vim.o[opt.k] = opt.v
    end
    M._maximized = nil
    vim.cmd("wincmd =")
  else
    M._maximized = {}
    local function set(k, v)
      table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
      vim.o[k] = v
    end
    set("winwidth", 999)
    set("winheight", 999)
    set("winminwidth", 10)
    set("winminheight", 4)
    vim.cmd("wincmd =")
  end
  -- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
  -- `VimLeavePre` might be another consideration? Not sure about differences between the 2
  vim.api.nvim_create_autocmd("ExitPre", {
    once = true,
    group = vim.api.nvim_create_augroup(
      "tm10ymhp_restore_max_exit_pre",
      { clear = true }
    ),
    desc = "Restore width/height when close Neovim while maximized",
    callback = function()
      M.maximize(false)
    end,
  })
end

return M
