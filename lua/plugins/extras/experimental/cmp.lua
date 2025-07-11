return {
  {
    "windwp/nvim-autopairs",
    optional = true,
    dependencies = { "nvim-cmp" },
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
    -- "yioneko/nvim-cmp",
    -- branch = "perf",
    -- "iguanacucumber/magazine.nvim", -- comparators broken
    -- name = "nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter /,?" },
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
              ---@diagnostic disable-next-line missing-fields
              formatting = {
                format = SereneNvim.cmp.format,
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
          ["<C-s>"] = cmp.mapping.complete({
            config = {
              sources = {
                { name = "codeium" },
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
            -- entry_filter = function(entry)
            --   return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            -- end,
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
          format = SereneNvim.cmp.format_complete,
          expandable_indicator = false,
        },
        experimental = { ghost_text = { hl_group = "CmpGhostText" } },
        sorting = {
          priority_weight = 2,
          comparators = {
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact, --
            -- cmp.config.compare.scopes, --
            cmp.config.compare.score, -- className
            cmp.config.compare.recently_used,
            -- cmp.config.compare.locality, --
            -- cmp.config.compare.kind, --
            -- cmp.config.compare.sort_text, -- tailwind border
            -- cmp.config.compare.length, -- php Request
            function(entry1, entry2)
              -- compare constants
              local kind1 = entry1:get_kind() --- @type lsp.CompletionItemKind | number
              local kind2 = entry2:get_kind() --- @type lsp.CompletionItemKind | number
              if kind1 ~= 21 and kind2 ~= 21 then
                return nil
              end

              return cmp.config.compare.length(entry1, entry2)
            end,
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
          disallow_prefix_unmatching = true,
          disallow_symbol_nonprefix_matching = true,
        },
        performance = {
          debounce = 100,
          throttle = 100,
          fetching_timeout = 500,
          confirm_resolve_timeout = 100,
          max_view_entries = 150,
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
        ---@diagnostic disable-next-line missing-fields
        matching = {
          disallow_prefix_unmatching = false,
        },
      })

      -- disabled nvim-cmp for command mode wildmenu
      -- https://github.com/hrsh7th/nvim-cmp/discussions/1731#discussion-5751566
      vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
        pattern = { ":" },
        desc = "Disable cmp in command mode",
        callback = function()
          local mappings = vim.api.nvim_get_keymap("c")
          for _, v in pairs(mappings) do
            if v.desc == "cmp.utils.keymap.set_map" then
              vim.keymap.del("c", v.lhs)
            end
          end
        end,
      })
    end,
  },
}
