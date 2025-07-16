---@class serenenvim.util.lsp
local M = {}

function M.get_capabilities()
  -- local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  local has_blink, blink = pcall(require, "blink.cmp")
  local has_lfo, lfo = pcall(require, "lsp-file-operations")
  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    -- has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    has_blink and blink.get_lsp_capabilities({}, false) or {},
    has_lfo and lfo.default_capabilities() or {},
    {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    }
  )

  return capabilities
end

function M.get_client_names()
  return vim
    .iter(vim.lsp.get_clients())
    :map(function(x) return x.name end)
    :totable()
end

function M.legacy_start()
  local function get_lsp_names()
    local files =
      vim.fn.glob(vim.fn.stdpath("config") .. "/after/lsp/*", true, true)
    -- vim.api.nvim_get_runtime_file("lsp/*.lua", true)
    local names = {}
    for _, file in pairs(files) do
      table.insert(names, vim.fn.fnamemodify(file, ":t:r"))
    end
    return names
  end

  local function get_lsp_configs()
    local names = get_lsp_names()
    local configs = {}
    for _, name in pairs(names) do
      if vim.lsp.config[name] ~= nil then
        configs[name] = vim.lsp.config[name]
      end
    end
    return configs
  end

  local function get_server_name_by_ft(filetype)
    local configs = get_lsp_configs()
    local matching_configs = {}
    for name, config in pairs(configs) do
      local filetypes = config.filetypes or {}
      for _, ft in pairs(filetypes) do
        if ft == filetype then
          table.insert(matching_configs, name)
          break
        end
      end
    end
    return matching_configs
  end

  local names = get_server_name_by_ft(vim.bo.filetype)
  if #names <= 0 then
    SereneNvim.info("LSP: No LSP server found for " .. vim.bo.filetype)
    return {}
  end
  SereneNvim.info("LSP: Start **" .. table.concat(names, "**, **") .. "**")

  vim.lsp.enable(names)

  return names
end

function M.legacy_stop()
  local name_clients = M.get_client_names()
  SereneNvim.info("LSP: Stop **" .. table.concat(name_clients, ", ") .. "**")
  vim.cmd("LspStop " .. table.concat(name_clients, " "))
end

function M.legacy_restart()
  local name_clients = M.get_client_names()
  SereneNvim.info("LSP: Restart **" .. table.concat(name_clients, ", ") .. "**")
  vim.cmd("LspRestart " .. table.concat(name_clients, " "))
end

return M
