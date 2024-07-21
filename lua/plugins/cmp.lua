return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")

      -- set this before configuring luasnip
      luasnip.filetype_extend("all", { "loremipsum" })
      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.setup()

      SereneNvim.hacks.luasnip()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = SereneNvim.lazy_init and "BufAdd" or "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {},
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = {
      SereneNvim.lazy_init and "BufAdd" or "InsertEnter",
      "CmdlineEnter /,?",
    },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "amarakon/nvim-cmp-buffer-lines",
    },
    opts = function()
      local cmp = require("cmp")

      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          -- https://github.com/neovim/neovim/issues/8435#issuecomment-2119332145
          ["<C-space>"] = function()
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
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<M-j>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<M-k>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<C-l>"] = cmp.mapping.complete({
            config = {
              formatting = {
                -- FIX: use same formatter except abbr limit
                format = function(entry, item)
                  item.kind = SereneNvim.config.icons.kinds[item.kind] or "?"
                  return item
                end,
              },
              sources = {
                {
                  name = "buffer-lines",
                  max_item_count = 40,
                  option = { leading_whitespace = false },
                },
              },
            },
          }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            max_item_count = 40,
            priority = 50,
            entry_filter = function(entry)
              return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
          },
          { name = "luasnip", max_item_count = 10, priority = 40 },
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
            item.kind = SereneNvim.config.icons.kinds[item.kind] or "?"

            item.menu = "["
              .. (SereneNvim.config.icons.sources[entry.source.name] or entry.source.name)
              .. "]"

            local function trim(text)
              local max = math.floor(0.35 * vim.o.columns)
              if text and text:len() > max then
                return text:sub(1, max) .. "…"
              else
                local padding = string.rep(" ", 5 - text:len())
                return text .. padding
              end
            end

            item.abbr = trim(item.abbr)

            return item
          end,
          expandable_indicator = false,
        },
        experimental = { ghost_text = { hl_group = "NonText" } },
        sorting = {
          priority_weight = 2,
          comparators = {
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            -- cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            -- cmp.config.compare.locality,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          documentation = {
            border = "single",
          },
          completion = {
            winhighlight = "CursorLine:PmenuSel,Search:None",
            border = "single",
            col_offset = -3,
          },
        },
        matching = {
          disallow_fuzzy_matching = true,
          disallow_fullfuzzy_matching = true,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = true,
          disallow_prefix_unmatching = false, -- snippets
          disallow_symbol_nonprefix_matching = true,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup(opts)

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
            name = "buffer",
            max_item_count = 40,
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
        },
        matching = {
          disallow_prefix_unmatching = false,
        },
      })

      SereneNvim.hacks.cmp()
    end,
  },
}
