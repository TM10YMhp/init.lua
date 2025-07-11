---@class serenenvim.util.hacks
local M = {}

function M.lualine()
  M.on_module("lualine_require", function(mod)
    -- PERF: we don't need this
    mod.require = require
  end)
end

function M.neo_tree()
  M.on_module("neo-tree.defaults", function(mod)
    -- remove icons
    table.remove(mod.renderers.directory, 2)
    table.remove(mod.renderers.file, 2)
  end)
end

function M.rest()
  M.on_module("rest-nvim", function(mod)
    -- only run in http filetype
    local message = table.concat({
      'RestNvim is only available for filetype "http"',
      'Current filetype is "' .. vim.bo.filetype .. '"',
    }, "\n")

    local run = mod.run
    mod.run = function(...)
      if vim.bo.filetype == "http" then return run(...) end

      SereneNvim.warn(message)
    end

    local last = mod.last
    mod.last = function(...)
      if vim.bo.filetype == "http" then return last(...) end

      SereneNvim.warn(message)
    end
  end)
end

function M.codeium()
  M.on_module("codeium.source", function(mod)
    -- toggle codeium
    -- https://github.com/Exafunction/codeium.nvim/issues/136
    local is_available = mod.is_available
    function mod:is_available()
      return is_available(self)
        and vim.g.codeium_enabled
        and not (vim.o.buftype == "nofile" or vim.o.buftype == "terminal")
    end
  end)
end

function M.project()
  M.on_module("project_nvim.utils.path", function(mod)
    -- check if directory exists
    local exists = mod.exists
    mod.exists = function(path)
      path = path:gsub("\\", "/")
      return vim.fn.isdirectory(path) == 1 or exists(path)
    end
  end)
end

function M.telescope()
  M.on_module("telescope.actions.state", function(mod)
    -- fix windows path duplicate, check project_nvim
    local get_selected_entry = mod.get_selected_entry
    mod.get_selected_entry = function()
      local entry = get_selected_entry()
      if entry and entry.path then
        entry.path = entry.path:gsub("/", "\\")
        entry.path = entry.path:gsub("\\%(", "/(")
        if package.loaded.project_nvim and SereneNvim.__IS_WINDOWS then
          entry.path = entry.path:sub(1, 1):upper() .. entry.path:sub(2)
        end
      end
      return entry
    end
  end)

  M.on_module("telescope.previewers.previewer", function(mod)
    local original_title = mod.title
    function mod:title(entry, dynamic)
      local title = original_title(self, entry, dynamic)
      if title then
        local folder = vim.fn.fnamemodify(title, ":h:t") .. "/"
        if folder ~= "./" then
          title = folder .. vim.fn.fnamemodify(title, ":t")
        else
          title = vim.fn.fnamemodify(title, ":t")
        end
      end
      return title
    end
  end)
end

function M.floating_preview()
  -- prevent load on init
  M.on_module("vim.lsp.util", function(mod)
    local open_floating_preview = mod.open_floating_preview
    mod.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.max_width = 80
      opts.max_height = 35
      opts.style = "minimal"
      opts.border = "single"

      local bufnr, winid = open_floating_preview(contents, syntax, opts, ...)
      -- autocmd
      -- vim.wo[winid].conceallevel = 0

      return bufnr, winid
    end
  end)
end

-- NOTE: https://github.com/nvim-telescope/telescope.nvim/pull/2640
local is_uri = function(filename)
  local URI_SCHEME_PATTERN = "^([a-zA-Z]+[a-zA-Z0-9.+-]*):.*"
  local WINDOWS_ROOT_PATTERN = "^[a-zA-Z]:\\"

  local is_uri_match = filename:match(URI_SCHEME_PATTERN) ~= nil
  local is_windows_root_match = filename:match(WINDOWS_ROOT_PATTERN)

  return is_uri_match and not is_windows_root_match
end

-- TODO: better doc, break telescope jdtls definitions
function M.uri_to_fname()
  -- fix telescope path_display truncate in `lsp_references`
  local uri_to_fname = vim.uri_to_fname
  vim.uri_to_fname = function(uri)
    local res = uri_to_fname(uri)

    if SereneNvim.__IS_WINDOWS and not is_uri(res) then
      res = res:sub(1, 1):upper() .. res:sub(2)
    end

    return res
  end
end

function M.reset_augroup()
  M.group = vim.api.nvim_create_augroup("serenenvim.hacks", { clear = true })
end

-- M._enabled_names = {}

function M.enable()
  M.reset_augroup()

  -- M.neo_tree()
  -- M.rest()
  -- M.project()

  M.floating_preview()
  -- M.uri_to_fname()

  -- M.on_module("vim.lsp", function(mod)
  --   local enable = mod.enable
  --   mod.enable = function(...)
  --     local name = select(1, ...)
  --     table.insert(M._enabled_names, name)
  --     return enable(...)
  --   end
  -- end)

  -- M.on_module("mason-lspconfig.features.automatic_enable", function(mod)
  --   local _ = require("mason-core.functional")
  --   local mason_pkg = require("mason-registry").get_installed_package_names()
  --   local mappings = require("mason-lspconfig.mappings")
  --   local disabled_servers = {}
  --
  --   local disable_autostart = function(mason_pkg)
  --     if type(mason_pkg) ~= "string" then mason_pkg = mason_pkg.name end
  --     local lspconfig_name =
  --       mappings.get_mason_map().package_to_lspconfig[mason_pkg]
  --     if not lspconfig_name then return end
  --     if disabled_servers[lspconfig_name] then return end
  --
  --     vim.lsp.enable(lspconfig_name, false)
  --     disabled_servers[lspconfig_name] = true
  --     vim.print("disabled " .. lspconfig_name)
  --   end
  --
  --   local init = mod.init
  --   mod.init = function(...)
  --     local r = init(...)
  --     -- vim.defer_fn(function() _.each(disable_autostart, mason_pkg) end, 1000)
  --     vim.schedule(function()
  --       vim.tbl_map(function(x) return disable_autostart(x) end, mason_pkg)
  --     end)
  --     return r
  --   end
  --
  --   local enable_all = mod.enable_all
  --   mod.enable_all = function(...)
  --     local r = enable_all(...)
  --     _.each(disable_autostart, mason_pkg)
  --     return r
  --   end
  -- end)
end

---@param modname string
---@param fn fun(mod)
function M.on_module(modname, fn)
  if type(package.loaded[modname]) == "table" then
    return fn(package.loaded[modname])
  end
  package.preload[modname] = function()
    package.preload[modname] = nil
    package.loaded[modname] = nil
    local mod = require(modname)
    fn(mod)
    return mod
  end
end

return M
