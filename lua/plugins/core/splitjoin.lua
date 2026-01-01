-- TODO: mru not work in lazy jump
return {
  {
    "nvim-mini/mini.splitjoin",
    opts = {
      mappings = {
        toggle = "",
        split = "",
        join = "",
      },
    },
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      { "gS", "<cmd>TSJToggle<cr>", desc = "Split / Join" },
    },
    opts = function()
      -- local use_mini = function()
      --   -- mini.splitjoin returns `nil` if nothing to toggle
      --   local res = require("mini.splitjoin").toggle()
      --   -- if not res then vim.cmd("normal! gww") end
      -- end
      --
      -- local langs = require("treesj.langs").presets
      -- for _, nodes in pairs(langs) do
      --   nodes.comment = {
      --     both = {
      --       fallback = use_mini,
      --     },
      --   }
      -- end

      -- local utils = require("treesj.langs.utils")
      local html = require("treesj.langs.html")

      return {
        use_default_keymaps = false,
        max_join_length = 150,
        langs = {
          astro = html,
        },
        notify = false,
        on_error = function()
          local opts = {}

          if vim.bo.filetype == "cmake" then opts = { detect = { separator = " " } } end

          require("mini.splitjoin").toggle(opts)
        end,
      }
    end,
  },
}
