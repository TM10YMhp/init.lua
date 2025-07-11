return {
  "dmmulroy/tsc.nvim",
  cmd = "TSC",
  init = function()
    SereneNvim.hacks.on_module("tsc.utils", function(mod)
      -- detect jsconfig.json
      local find_nearest_tsconfig = mod.find_nearest_tsconfig
      mod.find_nearest_tsconfig = function()
        if #find_nearest_tsconfig() ~= 0 then return find_nearest_tsconfig() end

        local jsconfig = vim.fn.findfile("jsconfig.json", ".;")
        return jsconfig ~= "" and { jsconfig } or {}
      end

      -- check if project use typescript
      local find_tsc_bin = mod.find_tsc_bin
      mod.find_tsc_bin = function()
        local tsc_bin = find_tsc_bin()
        if tsc_bin ~= "" then return vim.fn.exepath(tsc_bin) end

        return vim.fn.exepath("tsc")
      end
    end)
  end,
  opts = {
    flags = { watch = true },
    -- flags = "--build --noEmit",
    -- use_diagnostics = true,
  },
}
