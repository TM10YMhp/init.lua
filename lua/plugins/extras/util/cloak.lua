SereneNvim.on_lazy_init(function()
  vim.filetype.add({
    pattern = {
      -- match filenames like - ".env.example", ".env.local" and so on
      ["%.env%.[%w_.-]+"] = "sh",
    },
  })
end)

return {
  {
    "laytan/cloak.nvim",
    ft = { "sh", "minifiles" },
    init = function()
      SereneNvim.on_very_lazy(function()
        Snacks.toggle
          .new({
            name = "Shelter",
            get = function() return require("cloak").opts.enabled end,
            set = function(state)
              local cloak = require("cloak")
              if state then
                cloak.enable()
              else
                cloak.disable()
              end
            end,
          })
          :map("<leader>oC")
      end)
    end,
    opts = {
      enabled = true,
      cloak_character = "*",
      cloak_telescope = false,
    },
  },
  {
    "ph1losof/ecolog.nvim",
    ft = { "sh", "fzf" },
    opts = {
      shelter = {
        modules = {
          -- cmp = true,
          -- peek = true,
          files = false, -- FIX: not work
          -- telescope = true,
          -- telescope_previewer = true,
          fzf = true,
          fzf_previewer = true,
          snacks = true,
          snacks_previewer = true,
        },
      },
      integrations = { nvim_cmp = false },
      types = false,
      provider_patterns = {
        extract = false,
        cmp = false,
      },
    },
  },
}
