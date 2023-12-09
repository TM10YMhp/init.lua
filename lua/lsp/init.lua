require("lsp.mason")

local lspconfig = require("lspconfig")

require('lspconfig.ui.windows').default_options = {
  border = 'single',
}

local defaults = {
  autostart = false
}

local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status then
  defaults.capabilities = cmp_nvim_lsp.default_capabilities()
end

local dir = "servers"
local config_path = vim.fn.stdpath("config") .. "/lua/"
local files = vim.fn.split(vim.fn.glob(config_path .. dir .. "/*.lua", "\n"))

for _, file in pairs(files) do
  local name_file = vim.fn.fnamemodify(file, ":t:r")
  local server = require(dir .. "." .. name_file)
  if type(server) == "table" then
    local enabled = not (server.enabled == false)
    if enabled then
      if type(server.setup) == "function" then
        local opts = server.setup()
        local setup = vim.tbl_deep_extend("force", defaults, opts)
        local name = server[1]
        lspconfig[name].setup(setup)
      else
        for _, name in ipairs(server) do
          if type(name) == "string" then lspconfig[name].setup(defaults) end
        end
      end
    end
  end
end
