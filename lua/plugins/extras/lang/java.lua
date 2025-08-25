-- TODO: WIP

-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/581
-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/1714
-- https://nullprogram.com/blog/2011/08/30/

SereneNvim.on_lazy_init(
  function()
    vim.filetype.add({
      filename = {
        ["build.xml"] = "xml",
      },
    })
  end
)

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "java" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = {
      ensure_installed = { "jdtls", "java-debug-adapter" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>da",
        "<cmd>lua require'dap'.continue()<CR>",
        desc = "Debug: Start (JDTLS)",
      },
    },
    config = function()
      require("dap").configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Port 9000",
          hostName = "127.0.0.1",
          port = 9000,
        },
      }
    end,
  },
  {
    "google/styleguide",
    name = "java-google-styleguide",
    lazy = true,
  },
  {
    "mfussenegger/nvim-jdtls",
    init = function(plugin) require("lazy.core.loader").add_to_rtp(plugin) end,
  },
}
