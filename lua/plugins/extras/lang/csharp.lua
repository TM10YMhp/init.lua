-- TODO: WIP
SereneNvim.on_lazy_init(
  function()
    vim.filetype.add({
      extension = { xaml = "xml" },
    })
  end
)
SereneNvim.on_lazy_ft("roslyn.nvim", { "cs" })

-- TODO: check config
-- https://github.com/Sofistico/nvim_config/blob/master/lua/plugins/lspconfig.lua
return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "xml", "c_sharp" } },
  },
  {
    "mason.nvim",
    opts = {
      registries = {
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = { ensure_installed = { "roslyn" } },
  },
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
    config = function()
      -- respect no autostart
      local __f = false
      SereneNvim.hacks.on_module("vim.lsp", function(mod)
        local enable = mod.enable
        mod.enable = function(name, _enable)
          if not __f and name == "roslyn" then
            __f = true
            return
          end
          return enable(name, _enable)
        end
      end)

      require("roslyn").setup()

      vim.api.nvim_exec_autocmds(
        "FileType",
        { group = "roslyn.nvim", modeline = false, pattern = "cs" }
      )
    end,
  },
}
