return {
  {
    "blink.cmp",
    optional = true,
    dependencies = { "chrisgrieser/cmp-nerdfont" },
    opts = {
      sources = {
        default = { "nerdfont" },
        providers = {
          nerdfont = {
            name = "nerdfont",
            module = "blink.compat.source",
            kind = "NerdFont",
            transform_items = function(self, items)
              local insert =
                vim.regex(":_[^[:blank:]]*" .. "$"):match_str(self.line)
              for _, item in ipairs(items) do
                if item.textEdit and item.textEdit.newText then
                  if insert then item.textEdit.newText = item.word:sub(2) end
                end
              end
              return items
            end,
          },
        },
      },
    },
  },
  {
    "blink.cmp",
    optional = true,
    dependencies = { "kdheepak/cmp-latex-symbols" },
    opts = {
      sources = {
        default = { "latex_symbols" },
        providers = {
          ["latex_symbols"] = {
            enabled = function() return vim.o.filetype ~= "tex" end,
            name = "latex_symbols",
            module = "blink.compat.source",
            score_offset = -15,
            kind = "Latex",
          },
        },
      },
    },
  },
  {
    "blink.cmp",
    optional = true,
    dependencies = { "Arkissa/cmp-agda-symbols" },
    init = function()
      SereneNvim.hacks.on_module("cmp-agda-symbols", function(mod)
        local new = mod.new
        mod.new = function()
          return {
            get_trigger_characters = function() return { "\\" } end,
            get_keyword_pattern = function() return "\\\\[^[:blank:]]*" end,
            complete = function(self, request, callback)
              if
                not vim
                  .regex(self.get_keyword_pattern() .. "$")
                  :match_str(request.context.cursor_before_line)
              then
                return callback()
              end

              local symbol = require("cmp-agda-symbols.symbol")
              callback(symbol)
            end,
          }
        end
      end)
    end,
    opts = {
      sources = {
        default = { "agda-symbols" },
        providers = {
          ["agda-symbols"] = {
            name = "agda-symbols",
            module = "blink.compat.source",
            score_offset = -15,
            kind = "Agda",
          },
        },
      },
    },
  },
}
