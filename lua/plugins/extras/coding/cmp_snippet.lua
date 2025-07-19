-- vim.api.nvim_create_autocmd("ModeChanged", {
--   callback = function() vim.snippet.stop() end,
-- })

return {
  {
    "L3MON4D3/LuaSnip",
    -- enabled = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")

      -- set this before configuring luasnip
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.filetype_extend("all", { "loremipsum" })

      luasnip.setup()

      -- https://github.com/L3MON4D3/LuaSnip/issues/656
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
  },
  {
    -- https://github.com/Saghen/blink.cmp/issues/418
    "blink.cmp",
    optional = true,
    opts = {
      -- https://github.com/Saghen/blink.cmp/commit/e5b569c
      completion = {
        menu = {
          direction_priority = function()
            local ctx = require("blink.cmp").get_context()
            local item = require("blink.cmp").get_selected_item()
            if ctx == nil or item == nil then return { "s", "n" } end

            local item_text = item.textEdit ~= nil and item.textEdit.newText
              or item.insertText
              or item.label
            local is_multi_line = item_text:find("\n") ~= nil

            -- after showing the menu upwards, we want to maintain that direction
            -- until we re-open the menu, so store the context id in a global variable
            if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
              vim.g.blink_cmp_upwards_ctx_id = ctx.id
              return { "n", "s" }
            end
            return { "s", "n" }
          end,
          border = "single",
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              -- { "source_name" },
            },
          },
        },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "snippets" },
        providers = {
          snippets = {
            score_offset = -10,
            opts = {
              -- global_snippets = { "all", "loremipsum" },
            },
          },
        },
      },
    },
  },
}
