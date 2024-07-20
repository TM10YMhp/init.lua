local M = {}

function M.reset_augroup()
  M.group = vim.api.nvim_create_augroup("tm10ymhp.hacks", { clear = true })
end

function M.enable()
  M.reset_augroup()
  M.fix_rest()
  M.fix_conceallevel()
  M.fix_tsc()
  M.fix_neo_tree()
  M.fix_conform()
end

-- only run in http filetype
function M.fix_rest()
  M.on_module("rest-nvim", function(mod)
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

function M.fix_conceallevel()
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

-- detect jsconfig.json
function M.fix_tsc()
  M.on_module("tsc.utils", function(mod)
    local find_nearest_tsconfig = mod.find_nearest_tsconfig
    mod.find_nearest_tsconfig = function()
      find_nearest_tsconfig()

      local jsconfig = vim.fn.findfile("jsconfig.json", ".;")
      return jsconfig ~= "" and { jsconfig } or {}
    end

    local find_tsc_bin = mod.find_tsc_bin
    mod.find_tsc_bin = function()
      local tsc_bin = find_tsc_bin()

      if tsc_bin == "tsc" then
        return vim.fn.exepath("tsc")
      end

      return tsc_bin
    end
  end)
end

-- remove icons
function M.fix_neo_tree()
  M.on_module("neo-tree.defaults", function(mod)
    table.remove(mod.renderers.directory, 2)
    table.remove(mod.renderers.file, 2)
  end)
end

-- pretty info
function M.fix_conform()
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

---https://www.gammon.com.au/scripts/doc.php?lua=package.loaders
---@param fn fun(mod)
function M.on_module(module, fn)
  if package.loaded[module] then
    return fn(package.loaded[module])
  end

  -- FIX: loop and previous error
  package.preload[module] = function()
    package.preload[module] = nil
    for _, loader in pairs(package.loaders) do
      local ret = loader(module)
      if type(ret) == "function" then
        local mod = ret()
        fn(mod)
        return mod
      end
    end
  end
end

return M
