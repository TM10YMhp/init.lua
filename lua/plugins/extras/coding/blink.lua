return {
  {
    "saghen/blink.compat",
    -- version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "v1.*",
    opts_extend = { "sources.default" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<S-Tab>"] = { "select_and_accept", "fallback" },
        ["<C-f>"] = {
          function(cmp) return cmp.select_next({ jump_by = "source_id" }) end,
          "select_next",
        },
        ["<C-b>"] = {
          function(cmp) return cmp.select_prev({ jump_by = "source_id" }) end,
          "select_prev",
        },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<Right>"] = {},
          ["<Left>"] = {},
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then return { "buffer" } end
          if type == ":" or type == "@" then return { "cmdline" } end
          return {}
        end,
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = true,
            -- auto_show = function(ctx)
            --   return vim.fn.getcmdtype() == "/" or vim.fn.getcmdtype() == "?"
            -- end,
          },
        },
      },
      term = { enabled = false },
      completion = {
        keyword = { range = "full" },
        list = { selection = { auto_insert = false } },
        menu = {
          border = "single",
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              -- { "source_name" },
            },
          },
        },
        documentation = {
          -- auto_show = true,
          -- auto_show_delay_ms = 200,
          window = { border = "single" },
        },
        ghost_text = { enabled = true },
      },
      -- fuzzy = { max_typos = 0 },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            -- fallbacks = {},
            -- score_offset = 50,
            opts = { tailwind_color_icon = "█" },
          },
          buffer = {
            -- score_offset = -5,
            opts = {
              -- get_bufnrs = function()
              --   local buf = vim.api.nvim_get_current_buf()
              --   local byte_size = vim.api.nvim_buf_get_offset(
              --     buf,
              --     vim.api.nvim_buf_line_count(buf)
              --   )
              --   if byte_size > 1024 * 1024 then -- 1 Megabyte max
              --     return {}
              --   end
              --   return { buf }
              -- end,
              get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end,
            },
          },
          path = {
            opts = { ignore_root_slash = true },
          },
        },
      },
      appearance = {
        kind_icons = SereneNvim.config.icons.kinds,
      },
      signature = {
        enabled = true,
        window = { border = "single" },
      },
    },
    config = function(_, opts)
      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind =
            require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require("blink.cmp").setup(opts)

      -- NOTE: use blink.cmp only search
      -- vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
      --   pattern = { ":", "@" },
      --   callback = function()
      --     local mappings = vim.api.nvim_get_keymap("c")
      --     for _, v in pairs(mappings) do
      --       if v.desc == "blink.cmp" then vim.keymap.del("c", v.lhs) end
      --     end
      --   end,
      -- })
      --
      -- vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
      --   pattern = { ":", "@" },
      --   callback = function()
      --     local keymap = require("blink.cmp.keymap")
      --     local config = require("blink.cmp.config")
      --
      --     local cmdline_sources = require("blink.cmp.config").sources.cmdline
      --     if type(cmdline_sources) ~= "table" or #cmdline_sources > 0 then
      --       local cmdline_mappings =
      --         keymap.get_mappings(config.keymap.cmdline or config.keymap)
      --       require("blink.cmp.keymap.apply").cmdline_keymaps(cmdline_mappings)
      --     end
      --   end,
      -- })
    end,
  },
  {
    "blink.cmp",
    optional = true,
    dependencies = { "hrsh7th/cmp-buffer" },
    opts = {
      sources = {
        providers = {
          buffer = {
            name = "buffer",
            kind = "Text",
            module = "blink.compat.source",
            opts = {
              cmp_name = "buffer",
              keyword_length = 2,
              -- NOTE: custom trigger characters
              -- https://github.com/Saghen/blink.cmp/issues/1599
              -- keyword_pattern = [[\%([\$#&]\w*\|\k\+\)]],
              -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|[\$#&A-Za-z_\-]\w*\%([\-.]\w*\)*\)]],
              -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\k\+\|[\$#&A-Za-z_\-]\w*\%([\-.]\w*\)*\)]],
              keyword_pattern = [[[0-9a-f]\{7,40}\|\%(-\?\d\+\%(\.\d\+\)\?\|[\$#&_\-]\w*\%(-\w*\)*\)\|\k\+]],
            },
          },
        },
      },
    },
  },
}
