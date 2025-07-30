return {
  {
    "brenoprata10/nvim-highlight-colors",
    init = function()
      SereneNvim.on_very_lazy(function()
        Snacks.toggle
          .new({
            name = "Highlight Colors",
            get = function()
              return require("nvim-highlight-colors").is_active()
            end,
            set = function(state)
              local nvim_highlight_colors = require("nvim-highlight-colors")
              if state then
                nvim_highlight_colors.turnOn()
              else
                nvim_highlight_colors.turnOff()
              end
            end,
          })
          :map("<leader>ot")
      end)
    end,
    opts = {
      virtual_symbol = "█",
      enable_tailwind = true,
    },
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
      require("nvim-highlight-colors").turnOff()
    end,
  },
  -- https://github.com/js-everts/cmp-tailwind-colors
  -- NOTE: alpha not work
  -- {
  --   "blink.cmp",
  --   optional = true,
  --   opts = {
  --     completion = {
  --       menu = {
  --         draw = {
  --           components = {
  --             -- customize the drawing of kind icons
  --             kind_icon = {
  --               text = function(ctx)
  --                 -- default kind icon
  --                 local icon = ctx.kind_icon
  --                 -- if LSP source, check for color derived from documentation
  --                 if ctx.item.source_name == "LSP" then
  --                   local color_item = require("nvim-highlight-colors").format(
  --                     ctx.item.documentation,
  --                     {
  --                       kind = ctx.kind,
  --                       menu = "Color",
  --                     }
  --                   )
  --                   if color_item and color_item.abbr ~= "" then
  --                     icon = color_item.abbr
  --                   end
  --                   vim.schedule_wrap(vim.print)(
  --                     "debug: " .. vim.inspect(color_item)
  --                   )
  --                 end
  --                 return icon .. ctx.icon_gap
  --               end,
  --               highlight = function(ctx)
  --                 -- default highlight group
  --                 local highlight = "BlinkCmpKind" .. ctx.kind
  --                 -- if LSP source, check for color derived from documentation
  --                 if ctx.item.source_name == "LSP" then
  --                   local color_item = require("nvim-highlight-colors").format(
  --                     ctx.item.documentation,
  --                     { kind = ctx.kind }
  --                   )
  --                   if color_item and color_item.abbr_hl_group then
  --                     highlight = color_item.abbr_hl_group
  --                   end
  --                 end
  --                 return highlight
  --               end,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
