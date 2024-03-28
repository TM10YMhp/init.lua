-- https://code.visualstudio.com/docs/editor/intellisense#_types-of-completions
-- stylua: ignore
local kind_icons = {
  Text          = "w",
  Method        = "m",
  Function      = "m",
  Constructor   = "m",
  Field         = "f",
  Variable      = "v",
  Class         = "c",
  Interface     = "I",
  Module        = "M",
  Property      = "p",
  Unit          = "u",
  Value         = "E",
  Enum          = "E",
  Keyword       = "k",
  Snippet       = "s",
  Color         = "C",
  File          = "F",
  Reference     = "r",
  Folder        = "D",
  EnumMember    = "E",
  Constant      = "C",
  Struct        = "S",
  Event         = "e",
  Operator      = "o",
  TypeParameter = "T",
}

return {
  {
    "L3MON4D3/LuaSnip",
    -- event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      -- https://github.com/L3MON4D3/LuaSnip/issues/656
      local luasnip = require("luasnip")
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup(
          "UnlinkLuaSnipSnippetOnModeChange",
          { clear = true }
        ),
        pattern = { "s:n", "i:*" },
        desc = "Forget the current snippet when leaving the insert mode",
        callback = function(evt)
          -- If we have n active nodes, n - 1 will still remain after a
          -- `unlink_current()` call. We unlink all of them by wrapping the calls
          -- in a loop.
          while true do
            if
              luasnip.session
              and luasnip.session.current_nodes[evt.buf]
              and not luasnip.session.jump_active
            then
              luasnip.unlink_current()
            else
              break
            end
          end
        end,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "amarakon/nvim-cmp-buffer-lines",
    },
    opts = function()
      local cmp = require("cmp")

      return {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-s>"] = function()
            if cmp.visible() then
              if cmp.visible_docs() then
                cmp.close_docs()
              else
                cmp.open_docs()
              end
            else
              cmp.complete()
            end
          end,
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<C-l>"] = cmp.mapping.complete({
            config = {
              sources = {
                {
                  name = "buffer-lines",
                  max_item_count = 15,
                  option = { leading_whitespace = false },
                },
              },
            },
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 40 },
          { name = "luasnip", max_item_count = 10 },
          {
            name = "buffer",
            max_item_count = 15,
            option = {
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(
                  buf,
                  vim.api.nvim_buf_line_count(buf)
                )
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end,
            },
          },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            item.kind = kind_icons[item.kind] or "?"
            -- item.kind = "(" .. item.kind .. ")"

            -- item.menu = ""
            item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
            })[entry.source.name]
            -- item.menu = "("..entry.source.name..")"

            function trim(text)
              local max = math.floor(0.45 * vim.o.columns)
              if text and text:len() > max then
                text = text:sub(1, max) .. "..."
              end
              return text
            end

            item.abbr = trim(item.abbr)

            return item
          end,
          expandable_indicator = false,
        },
        experimental = { ghost_text = false },
        sorting = {
          -- priority_weight = 2,
          comparators = {
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            -- cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          documentation = { border = "single" },
        },
        matching = {
          disallow_fuzzy_matching = true,
          disallow_fullfuzzy_matching = true,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = true,
          disallow_prefix_unmatching = true,
        },
      }
    end,
  },
}
