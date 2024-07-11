return {
  "echasnovski/mini.bracketed",
  keys = function(self)
    -- stylua: ignore
    local variants = {
      jump       = { mode = { "n", "o" } },
      comment    = { mode = { "n", "x", "o" } },
      conflict   = { mode = { "n", "x", "o" } },
      diagnostic = { mode = { "n", "x", "o" } },
      indent     = { mode = { "n", "x", "o" } },
      treesitter = { mode = { "n", "x", "o" } },
    }

    local mappings = {}
    for k, v in pairs(self.opts) do
      local low, up = v.suffix:lower(), v.suffix:upper()
      local key = k:gsub("^%l", string.upper)
      local mode = variants[k] and variants[k].mode or { "n" }

      table.insert(mappings, { "[" .. up, mode = mode, desc = key .. " first" })
      table.insert(mappings, { "]" .. up, mode = mode, desc = key .. " last" })
      table.insert(
        mappings,
        { "[" .. low, mode = mode, desc = key .. " backward" }
      )
      table.insert(
        mappings,
        { "]" .. low, mode = mode, desc = key .. " forward" }
      )
    end
    return mappings
  end,
  -- stylua: ignore
  opts = {
    buffer     = { suffix = 'b', options = {} },
    comment    = { suffix = 'g', options = {} },
    conflict   = { suffix = 'x', options = {} },
    diagnostic = { suffix = 'e', options = {} },
    file       = { suffix = 'f', options = {} },
    indent     = { suffix = 'i', options = { change_type = 'diff'} },
    jump       = { suffix = 'j', options = {} },
    oldfile    = { suffix = 'o', options = {} },
    location   = { suffix = 'l', options = {} },
    quickfix   = { suffix = 'q', options = {} },
    treesitter = { suffix = 't', options = {} },
    undo       = { suffix = 'u', options = {} },
    window     = { suffix = 'w', options = {} },
    yank       = { suffix = 'y', options = {} },
  },
}
