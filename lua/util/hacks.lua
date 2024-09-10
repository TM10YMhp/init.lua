---@class serenenvim.util.hacks
local M = {}

function M.lualine()
  M.on_module("lualine_require", function(mod)
    -- PERF: we don't need this
    mod.require = require
  end)
end

function M.tsc()
  M.on_module("tsc.utils", function(mod)
    -- detect jsconfig.json
    local find_nearest_tsconfig = mod.find_nearest_tsconfig
    mod.find_nearest_tsconfig = function()
      if #find_nearest_tsconfig() ~= 0 then
        return find_nearest_tsconfig()
      end

      local jsconfig = vim.fn.findfile("jsconfig.json", ".;")
      return jsconfig ~= "" and { jsconfig } or {}
    end

    mod.find_tsc_bin = function()
      return vim.fn.exepath("tsc")
    end
  end)
end

function M.conform()
  M.on_module("conform.health", function(mod)
    local show_window = mod.show_window
    mod.show_window = function()
      show_window()

      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_config(win, { border = "single" })
      vim.wo[win].wrap = true
    end
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
      if vim.bo.filetype == "http" then
        return run(...)
      end

      SereneNvim.warn(message)
    end

    local last = mod.last
    mod.last = function(...)
      if vim.bo.filetype == "http" then
        return last(...)
      end

      SereneNvim.warn(message)
    end
  end)
end

function M.cmp()
  -- disabled nvim-cmp for command mode wildmenu
  -- https://github.com/hrsh7th/nvim-cmp/discussions/1731#discussion-5751566
  vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    pattern = { ":" },
    group = M.group,
    desc = "Disable cmp in command mode",
    callback = function()
      local mappings = vim.api.nvim_get_keymap("c")
      for _, v in pairs(mappings) do
        if v.desc == "cmp.utils.keymap.set_map" then
          vim.keymap.del("c", v.lhs)
        end
      end
    end,
  })
end

function M.codeium()
  M.on_module("codeium.source", function(mod)
    -- toggle codeium
    -- https://github.com/Exafunction/codeium.nvim/issues/136
    local is_available = mod.is_available
    function mod:is_available()
      return is_available(self) and vim.g.codeium_enabled
    end
  end)
end

function M.luasnip()
  M.on_module("luasnip", function(mod)
    -- https://github.com/L3MON4D3/LuaSnip/issues/656
    vim.api.nvim_create_autocmd("ModeChanged", {
      group = M.group,
      pattern = { "s:n", "i:*" },
      desc = "Forget the current snippet when leaving the insert mode",
      callback = function(evt)
        -- if we have n active nodes, n - 1 will still remain after a
        -- `unlink_current()` call. We unlink all of them by wrapping the calls
        -- in a loop.
        while true do
          if
            mod.session
            and mod.session.current_nodes[evt.buf]
            and not mod.session.jump_active
          then
            mod.unlink_current()
          else
            break
          end
        end
      end,
    })
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
    local is_windows = vim.fn.has("win32") or vim.fn.has("wsl")

    local get_selected_entry = mod.get_selected_entry
    mod.get_selected_entry = function()
      local entry = get_selected_entry()
      if entry.path then
        entry.path = entry.path:gsub("/", "\\")
        entry.path = entry.path:gsub("\\%(", "/(")
        if package.loaded.project_nvim and is_windows then
          entry.path = entry.path:sub(1, 1):upper() .. entry.path:sub(2)
        end
      end
      return entry
    end
  end)
end

function M.conceallevel()
  M.on_module("vim.lsp.util", function(mod)
    local open_floating_preview = mod.open_floating_preview
    mod.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.max_width = 80
      opts.max_height = 35
      opts.style = "minimal"
      opts.border = "single"

      local bufnr, winid = open_floating_preview(contents, syntax, opts, ...)
      vim.wo[winid].conceallevel = 0

      return bufnr, winid
    end
  end)
end

function M.reset_augroup()
  M.group = vim.api.nvim_create_augroup("serenenvim.hacks", { clear = true })
end

function M.enable()
  M.reset_augroup()

  M.lualine()
  M.tsc()
  M.conform()
  M.neo_tree()
  M.rest()
  M.cmp()
  M.codeium()
  M.luasnip()
  M.project()
  M.telescope()
  M.conceallevel()
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
