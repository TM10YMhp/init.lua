return {
  "L3MON4D3/LuaSnip",
  enabled = false,
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local luasnip = require("luasnip")

    -- set this before configuring luasnip
    luasnip.filetype_extend("all", { "loremipsum" })
    luasnip.filetype_extend("astro", { "html" })
    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.setup()

    -- -- https://github.com/L3MON4D3/LuaSnip/issues/656
    -- vim.api.nvim_create_autocmd("ModeChanged", {
    --   group = M.group,
    --   pattern = { "s:n", "i:*" },
    --   desc = "Forget the current snippet when leaving the insert mode",
    --   callback = function(evt)
    --     -- if we have n active nodes, n - 1 will still remain after a
    --     -- `unlink_current()` call. We unlink all of them by wrapping the calls
    --     -- in a loop.
    --     while true do
    --       if
    --         luasnip.session
    --         and luasnip.session.current_nodes[evt.buf]
    --         and not luasnip.session.jump_active
    --       then
    --         luasnip.unlink_current()
    --       else
    --         break
    --       end
    --     end
    --   end,
    -- })

    -- https://github.com/L3MON4D3/LuaSnip/issues/258
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*",
      callback = function()
        if
          (
            (vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")
            or vim.v.event.old_mode == "i"
          )
          and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
        then
          require("luasnip").unlink_current()
        end
      end,
    })
  end,
}
