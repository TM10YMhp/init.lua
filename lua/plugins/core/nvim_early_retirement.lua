return {
  {
    "chrisgrieser/nvim-early-retirement",
    event = "BufLeave",
    opts = {
      retirementAgeMins = 15,
      notificationOnAutoClose = true,
      deleteBufferWhenFileDeleted = false,
      ignoreAltFile = false,
      minimumBufferNum = 1,
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    keys = {
      {
        "<leader>bp",
        function()
          local state = require("bufferline.state")
          local commands = require("bufferline.commands")
          local _, element = commands.get_current_element_index(state)
          if not element then
            SereneNvim.info("No buffer to toggle pin")
            return
          end

          local groups = require("bufferline.groups")
          if groups._is_pinned(element) then
            groups.remove_element("pinned", element)
            SereneNvim.warn("Unpinned: " .. element.name)
            vim.b.ignore_early_retirement = false
          else
            groups.add_element("pinned", element)
            SereneNvim.info("Pinned: " .. element.name)
            vim.b.ignore_early_retirement = true
          end
          require("bufferline.ui").refresh()
        end,
        desc = "Toggle pin",
      },
    },
  },
}
