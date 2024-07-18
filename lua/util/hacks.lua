local M = {}

function M.reset_augroup()
  M.group = vim.api.nvim_create_augroup("tm10ymhp.hacks", { clear = true })
end

function M.enable()
  M.reset_augroup()
  M.fix_tsc()
  M.fix_neo_tree()
end

-- HACK: tsc detect jsconfig.json
function M.fix_tsc()
  M.on_module("tsc.utils", function(mod)
    local find_nearest_tsconfig = mod.find_nearest_tsconfig

    function mod.find_nearest_tsconfig()
      find_nearest_tsconfig()

      local jsconfig = vim.fn.findfile("jsconfig.json", ".;")
      return jsconfig ~= "" and { jsconfig } or {}
    end
  end)
end

-- HACK: remove icons
function M.fix_neo_tree()
  M.on_module("neo-tree.defaults", function(mod)
    table.remove(mod.renderers.directory, 2)
    table.remove(mod.renderers.file, 2)
  end)
end

---https://www.gammon.com.au/scripts/doc.php?lua=package.loaders
---@param fn fun(mod)
function M.on_module(module, fn)
  if package.loaded[module] then
    return fn(package.loaded[module])
  end

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
