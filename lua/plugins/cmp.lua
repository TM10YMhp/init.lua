local cmp_kinds = {
  Text = 'b',
  Method = 'f',
  Function = 'f',
  Constructor = 'f',
  Field = 'm',
  Variable = 'v',
  Class = 'C',
  Interface = 'I',
  Module = 'M',
  Property = 'm',
  Unit = 'U',
  Value = 'v',
  Enum = 'E',
  Keyword = 'k',
  Snippet = 'S',
  Color = 'v',
  File = 'F',
  Reference = 'r',
  Folder = 'F',
  EnumMember = 'm',
  Constant = 'v',
  Struct = 'S',
  Event = 'E',
  Operator = 'O',
  TypeParameter = 'T',
}

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end
    },
    config = function()
      require("luasnip").setup({})

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
    end
  },
  {
    "windwp/nvim-autopairs",
    keys = function()
      local ret = {}
      for _, key in ipairs({ '"', "'", "(", ")", "[", "]", "`", "{", "}" }) do
        ret[#ret + 1] = { key, mode = "i", desc = "autopairs map key" }
      end

      ret[#ret + 1] = { "<BS>", mode = "i", desc = "v:lua.MPairs.autopairs_bs()" }
      ret[#ret + 1] = { "<CR>", mode = "i", desc = "v:lua.MPairs.completion_confirm()" }

      return ret
    end,
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "amarakon/nvim-cmp-buffer-lines",
    },
    opts = function ()
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
        view = {
          entries = "native",
          -- docs = { auto_open = false }
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-s>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select
          }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select
          }),
          ['<C-g>'] = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,
          ['<C-l>'] = cmp.mapping.complete({
            config = {
              sources = {
                {
                  name = "buffer-lines",
                  max_item_count = 5,
                  option = { leading_whitespace = false }
                }
              }
            }
          }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', max_item_count = 50 },
          { name = 'luasnip' },
        }, {
          {
            name = 'buffer',
            max_item_count = 20,
            option = {
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(
                  buf, vim.api.nvim_buf_line_count(buf)
                )
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end
            }
          },
        }),
        formatting = {
          --fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind] or "?"
            vim_item.menu = ""
            -- vim_item.menu = "("..entry.source.name..")"

            return vim_item
          end,
          expandable_indicator = false
        },
        experimental = { ghost_text = false },
        sorting = {
          comparators = {
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            cmp.config.compare.score,
            -- cmp.config.compare.recently_used,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            cmp.config.compare.length,
            -- cmp.config.compare.order,
          },
        },
        window = {
          documentation = { border = "single" }
        },
        matching = {
          disallow_fuzzy_matching = true,
          disallow_fullfuzzy_matching = true,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = true,
          disallow_prefix_unmatching = true,
        },
      }
    end
  }
}
