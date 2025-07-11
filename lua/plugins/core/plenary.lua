return {
  "nvim-lua/plenary.nvim",
  lazy = true,
  init = function()
    SereneNvim.hacks.on_module("plenary.path", function(mod)
      -- fix routes in mru with $id.tsx
      -- no extend env vars in windows
      local expand = mod.expand
      function mod:expand()
        local ok, expanded = pcall(expand, self)
        local match = string.find(self.filename, "%$")

        if not ok and not match then error("Path not valid") end

        if match then expanded = self.filename end

        return expanded
      end
    end)

    SereneNvim.hacks.on_module("plenary.log", function(mod)
      -- correct path in windows
      local new = mod.new
      function mod.new(config, standalone)
        config.plugin = config.plugin:gsub("/", "\\")
        return new(config, standalone)
      end
    end)
  end,
}
