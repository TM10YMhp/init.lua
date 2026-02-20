-- TODO: why not work in `init`?
SereneNvim.hacks.on_module("snacks.util", function(mod)
  local blend = mod.blend
  mod.blend = function(fg, bg, alpha)
    fg = fg or "#000000"
    return blend(fg, bg, alpha)
  end
end)

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.g.snacks_animate = false

    SereneNvim.on_very_lazy(function()
      -- Setup some globals for debugging (lazy-loaded)
      _G.dd = function(...) Snacks.debug.inspect(...) end
      _G.bt = function() Snacks.debug.backtrace() end

      -- Create some toggle mappings
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>os")
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
      Snacks.toggle.option("number", { name = "Line Numbers" }):map("<leader>on")
      Snacks.toggle.option("list", { name = "List" }):map("<leader>oo")
      Snacks.toggle.option("termguicolors", { name = "Termguicolors" }):map("<leader>oc")
      Snacks.toggle
        .new({
          id = "inlay_hints",
          name = "Inlay Hints",
          get = function() return vim.lsp.inlay_hint.is_enabled() end,
          set = function(state) vim.lsp.inlay_hint.enable(state) end,
        })
        :map("<leader>oh")

      SereneNvim.snacks.simple_lsp_progress()
    end)
  end,
  keys = {
    {
      "<leader>uM",
      function() Snacks.debug.metrics() end,
      desc = "Metrics",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse({
          notify = false,
          open = function(url)
            vim.notify(url)
            vim.fn.setreg("+", url)
          end,
        })
      end,
      desc = "Git Browse (copy)",
      mode = { "n", "v" },
    },
    {
      "<leader>sn",
      function() Snacks.notifier.show_history() end,
      desc = "Notification History",
    },
    {
      "<leader>un",
      function() Snacks.notifier.hide() end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>bd",
      function() Snacks.bufdelete() end,
      desc = "Delete Buffer",
    },
    {
      "<leader>bD",
      function() Snacks.bufdelete.all() end,
      desc = "Delete All Buffer",
    },
    {
      "<leader>bw",
      function() Snacks.bufdelete({ wipe = true }) end,
      desc = "Wipeout Buffer",
    },
    {
      "<leader>bW",
      function() Snacks.bufdelete.all({ wipe = true }) end,
      desc = "Wipeout All Buffer",
    },
    {
      "<leader>bo",
      function() Snacks.bufdelete.other() end,
      desc = "Delete Other Buffers",
    },
    {
      "<leader>cr",
      function() Snacks.rename.rename_file() end,
      desc = "Rename File",
    },
  },
  opts = {
    scope = {
      enabled = false,
      debounce = 1000,
      treesitter = false,
    },
    styles = {
      float = {
        border = "single",
      },
      scratch = {
        width = 0.9,
        height = 0.9,
        border = "single",
      },
      notification = {
        border = "single",
        wo = {
          wrap = true,
          linebreak = false,
        },
      },
      notification_history = {
        border = "single",
        width = 0.8,
        height = 0.8,
        minimal = true,
        wo = {
          wrap = true,
          linebreak = false,
          foldcolumn = "0",
        },
      },
      lazygit = {
        border = "single",
      },
      input = {
        border = "single",
      },
    },
    lazygit = {
      config = {
        gui = { nerdFontsVersion = "" },
      },
    },
    bigfile = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 2500,
      width = { min = 28, max = 0.75 },
      height = { min = 1, max = 0.75 },
      margin = { top = 0, right = 0, bottom = 1 },
      -- stylua: ignore
      icons = {
        error = "",
        warn  = "",
        info  = "",
        debug = "",
        trace = "",
      },
      padding = true,
      top_down = false,
      refresh = 500,
    },
    input = {
      enabled = false,
      icon = "",
      expand = false,
    },
    image = {
      enabled = true,
    },
  },
}
