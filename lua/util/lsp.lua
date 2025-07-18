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
    local names = vim.tbl_map(
      function(x) return vim.fn.fnamemodify(x, ":t:r") end,
      files
    )
    return names
  end

  local has_root = function(config)
    local bufnr = vim.api.nvim_get_current_buf()
    if not config.root_dir and config.root_markers then
      vim.validate("root_markers", config.root_markers, "table")
      local path = vim.fs.root(bufnr, config.root_markers)
      return path ~= nil
    elseif type(config.root_dir) == "function" then
      local path = nil
      config.root_dir(bufnr, function(root_dir) path = root_dir end)
      return path ~= nil
    end
  end

  local function get_lsp_configs()
    local names = get_lsp_names()
    local configs = {}
    for i, name in pairs(names) do
      local config = vim.lsp.config[name]
      if config ~= nil and has_root(config) then
        configs[#configs + 1] = config
      end
    end
    return configs
  end

  local function get_server_name_by_ft(filetype)
    local configs = get_lsp_configs()
    local names = {}
    for _, config in pairs(configs) do
      local filetypes = config.filetypes or {}
      if filetypes and vim.tbl_contains(filetypes, filetype) then
        names[#names + 1] = config.name
      end
    end
    return names
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
