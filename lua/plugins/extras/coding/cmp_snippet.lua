vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function() vim.snippet.stop() end,
})

return {
  {
    "blink.cmp",
    optional = true,
    -- https://github.com/Saghen/blink.cmp/issues/418
    dependencies = { "ydkulks/friendly-snippets" },
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
      -- snippets = { preset = "luasnip" },
      sources = {
        default = { "snippets" },
        providers = {
          snippets = {
            score_offset = -10,
            opts = { global_snippets = { "all", "loremipsum" } },
          },
        },
      },
    },
  },
}
