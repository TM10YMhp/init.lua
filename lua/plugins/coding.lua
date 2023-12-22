local kind_icons = {
  Text = 't',
  Method = 'm',
  Function = 'f',
  Constructor = 'c',
  Field = 'd',
  Variable = 'v',
  Class = 'C',
  Interface = 'I',
  Module = 'M',
  Property = 'p',
  Unit = 'u',
  Value = 'l',
  Enum = 'E',
  Keyword = 'k',
  Snippet = 's',
  Color = 'o',
  File = 'F',
  Reference = 'r',
  Folder = 'D',
  EnumMember = 'e',
  Constant = 'n',
  Struct = 'S',
  Event = 'e',
  Operator = 'O',
  TypeParameter = 'P',
}

local utils = require("tm10ymhp.utils")

return {
  {
    "Exafunction/codeium.vim",
    -- event = "VeryLazy", -- Await Auth
    event = "InsertEnter",
    cmd = "Codeium",
    keys = {
      {
        "<M-y>",
        function() return vim.fn['codeium#Accept']() end,
        mode = "i",
        desc = "Codeium: Accept",
        expr = true,
        silent = true,
      },
      {
        "<M-e>",
        function() return vim.fn['codeium#Clear']() end,
        mode = "i",
        desc = "Codeium: Clear",
        expr = true,
        silent = true,
      },
      {
        "<M-n>",
        function() return vim.fn['codeium#CycleOrComplete']() end,
        mode = "i",
        desc = "Codeium: Next Completion",
        expr = true,
        silent = true,
      },
      {
        "<M-p>",
        function() return vim.fn['codeium#CycleCompletions'](-1) end,
        mode = "i",
        desc = "Codeium: Prev Completion",
        expr = true,
        silent = true,
      },
      {
        "<leader>ua",
        function()
          if vim.g.codeium_enabled then
            vim.g.codeium_enabled = false
            utils.notify("Codeium disabled")
          else
            vim.g.codeium_enabled = true
            utils.notify("Codeium enabled")
          end
        end,
        desc = "Toggle Codeium"
      },
    },
  },
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
    "hrsh7th/cmp-nvim-lsp",
    event = "LspAttach",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "amarakon/nvim-cmp-buffer-lines",
      {
        "windwp/nvim-autopairs",
        config = true
      },
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
          -- entries = "native",
          -- docs = { auto_open = false }
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ['<C-s>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
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
                  max_item_count = 20,
                  option = { leading_whitespace = false }
                }
              }
            }
          }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', max_item_count = 40 },
          { name = 'luasnip', max_item_count = 10 },
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
          -- fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            item.kind = kind_icons[item.kind] or "?"
            item.menu = ""

            -- item.menu = "("..entry.source.name..")"

            return item
          end,
          expandable_indicator = false
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
  },
  {
    "kylechui/nvim-surround",
    keys = {
      { "cs", desc = "Change a surrounding pair" },
      { "cS", desc = "Change a surrounding pair, putting replacements on new lines" },
      { "ds", desc = "Delete a surrounding pair" },
      { "S", mode = "x" ,desc = "Add a surrounding pair around a visual selection" },
      { "ys", desc = "Add a surrounding pair around a motion (normal mode)" },
      { "yss", desc = "Add a surrounding pair around the current line (normal mode)" },
      { "ySS", desc = "Add a surrounding pair around the current line, on new lines (normal mode)" },
      { "yS", desc = "Add a surrounding pair around a motion, on new lines (normal mode)" },
      { "gS", mode = "x", desc = "Add a surrounding pair around a visual selection, on new lines" },
      { "<C-G>S", mode = "i", desc = "Add a surrounding pair around the cursor, on new lines (insert mode)" },
      { "<C-G>s", mode = "i", desc = "Add a surrounding pair around the cursor (insert mode)" },
    },
    config = true
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcO", desc = "Comment insert above" },
      { "gco", desc = "Comment insert below" },
      { "gc", desc = "Comment toggle linewise" },
      { "gb", desc = "Comment toggle blockwise" },
      { "gcA", desc = "Comment insert end of line" },
      { "gcc", desc = "Comment toggle current line" },
      { "gbc", desc = "Comment toggle current block" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      }
    },
    opts = function()
      return {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = 'gcc',
          block = 'gbc'
        },
        opleader = {
          line = 'gc',
          block = 'gb'
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA'
        },
        mappings = {
          basic = true,
          extra = true
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim')
          .create_pre_hook(),
        post_hook = nil,
      }
    end
  },
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "o", "x" }, desc = "Around textobject" },
      { "i", mode = { "o", "x" }, desc = "Inside textobject" },
    },
    opts = {
      mappings = {
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
        goto_left = '',
        goto_right = '',
      },
      n_lines = 500
    }
  },
  {
    "echasnovski/mini.completion",
    event = "InsertEnter",
    opts = {
      delay = { completion = 1000 * 60 * 5 },
      window = {
        info = { border = "single" },
        signature = { border = "single" },
      },
      lsp_completion = {
        auto_setup = false,
      },
      mappings = {
        force_twostep = "",
        force_fallback = "",
      },
      set_vim_settings = false
    },
  }
}
