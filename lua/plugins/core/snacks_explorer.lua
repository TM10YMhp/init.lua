return {
  "folke/snacks.nvim",
  init = function()
    SereneNvim.hacks.on_module("snacks.explorer.actions", function(mod)
      local update = mod.update
      mod.update = function(picker, opts)
        opts = opts or {}
        local target = type(opts.target) == "string" and vim.fs.normalize(opts.target) or nil --[[@as string]]
        opts.target = target
        return update(picker, opts)
      end
    end)
  end,
  opts = {
    explorer = {},
  },
  keys = {
    {
      "<leader>ee",
      function() Snacks.explorer({ cwd = vim.fn.getcwd() }) end,
      desc = "Explorer Snacks (root)",
    },
    {
      "<leader>eE",
      function() Snacks.explorer({ cwd = vim.fn.expand("%:p:h") }) end,
      desc = "Explorer Snacks (dir)",
    },
  },
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = false,
          follow = true,
          layout = {
            cycle = false,
            layout = { position = "right" },
          },
          win = {
            list = {
              keys = {
                ["]w"] = false,
                ["[w"] = false,
                ["]e"] = false,
                ["[e"] = false,
              },
            },
          },
        },
      },
    },
  },
}
