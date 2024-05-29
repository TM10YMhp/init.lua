-- TODO: better descriptions
return {
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "o", "x" }, desc = "Around textobject" },
      { "i", mode = { "o", "x" }, desc = "Inside textobject" },
    },
    opts = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter

      return {
        mappings = {
          around_next = "",
          inside_next = "",
          around_last = "",
          inside_last = "",
          goto_left = "",
          goto_right = "",
        },
        n_lines = 500,
        custom_textobjects = {
          -- Need 'nvim-treesitter/nvim-treesitter-textobjects'
          o = spec_treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
          C = spec_treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },
  {
    "echasnovski/mini.bracketed",
    keys = {
      { "[B", desc = "Buffer first" },
      { "]B", desc = "Buffer last" },
      { "]b", desc = "Buffer forward" },
      { "[b", desc = "Buffer backward" },

      { "[C", mode = { "n", "x", "o" }, desc = "Comment first" },
      { "]C", mode = { "n", "x", "o" }, desc = "Comment last" },
      { "]c", mode = { "n", "x", "o" }, desc = "Comment forward" },
      { "[c", mode = { "n", "x", "o" }, desc = "Comment backward" },

      { "[X", mode = { "n", "x", "o" }, desc = "Conflict first" },
      { "]X", mode = { "n", "x", "o" }, desc = "Conflict last" },
      { "]x", mode = { "n", "x", "o" }, desc = "Conflict forward" },
      { "[x", mode = { "n", "x", "o" }, desc = "Conflict backward" },

      { "[E", mode = { "n", "x", "o" }, desc = "Diagnostic first" },
      { "]E", mode = { "n", "x", "o" }, desc = "Diagnostic last" },
      { "]e", mode = { "n", "x", "o" }, desc = "Diagnostic forward" },
      { "[e", mode = { "n", "x", "o" }, desc = "Diagnostic backward" },

      { "[F", desc = "File first" },
      { "]F", desc = "File last" },
      { "]f", desc = "File forward" },
      { "[f", desc = "File backward" },

      { "[I", mode = { "n", "x", "o" }, desc = "Indent first" },
      { "]I", mode = { "n", "x", "o" }, desc = "Indent last" },
      { "]i", mode = { "n", "x", "o" }, desc = "Indent forward" },
      { "[i", mode = { "n", "x", "o" }, desc = "Indent backward" },

      { "[J", mode = { "n", "o" }, desc = "Jump first" },
      { "]J", mode = { "n", "o" }, desc = "Jump last" },
      { "]j", mode = { "n", "o" }, desc = "Jump forward" },
      { "[j", mode = { "n", "o" }, desc = "Jump backward" },

      { "[O", desc = "Oldfile first" },
      { "]O", desc = "Oldfile last" },
      { "]o", desc = "Oldfile forward" },
      { "[o", desc = "Oldfile backward" },

      { "[L", desc = "Location first" },
      { "]L", desc = "Location last" },
      { "]l", desc = "Location forward" },
      { "[l", desc = "Location backward" },

      { "[Q", desc = "Quickfix first" },
      { "]Q", desc = "Quickfix last" },
      { "]q", desc = "Quickfix forward" },
      { "[q", desc = "Quickfix backward" },

      { "[T", mode = { "n", "x", "o" }, desc = "Treesitter first" },
      { "]T", mode = { "n", "x", "o" }, desc = "Treesitter last" },
      { "]t", mode = { "n", "x", "o" }, desc = "Treesitter forward" },
      { "[t", mode = { "n", "x", "o" }, desc = "Treesitter backward" },

      { "[U", desc = "Undo first" },
      { "]U", desc = "Undo last" },
      { "]u", desc = "Undo forward" },
      { "[u", desc = "Undo backward" },

      { "[W", desc = "Window first" },
      { "]W", desc = "Window last" },
      { "]w", desc = "Window forward" },
      { "[w", desc = "Window backward" },

      { "[Y", desc = "Yank first" },
      { "]Y", desc = "Yank last" },
      { "]y", desc = "Yank forward" },
      { "[y", desc = "Yank backward" },
    },
    opts = {
      -- stylua: ignore start
      buffer     = { suffix = 'b', options = {} },
      comment    = { suffix = 'c', options = {} },
      conflict   = { suffix = 'x', options = {} },
      diagnostic = { suffix = 'e', options = {} },
      file       = { suffix = 'f', options = {} },
      indent     = { suffix = 'i', options = { change_type = 'diff'} },
      jump       = { suffix = 'j', options = {} },
      oldfile    = { suffix = 'o', options = {} },
      location   = { suffix = 'l', options = {} },
      quickfix   = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      undo       = { suffix = 'u', options = {} },
      window     = { suffix = 'w', options = {} },
      yank       = { suffix = 'y', options = {} },
      -- stylua: ignore end
    },
  },
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align" },
      { "gA", mode = { "n", "x" }, desc = "Align with preview" },
    },
    config = true,
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<M-k>", desc = "Move line up" },
      { "<M-j>", desc = "Move line down" },
      { "<M-h>", desc = "Move line left" },
      { "<M-l>", desc = "Move line right" },

      { "<M-k>", mode = "x", desc = "Move up" },
      { "<M-j>", mode = "x", desc = "Move down" },
      { "<M-h>", mode = "x", desc = "Move left" },
      { "<M-l>", mode = "x", desc = "Move right" },
    },
    config = true,
  },
  {
    "echasnovski/mini.trailspace",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ct",
        function()
          MiniTrailspace.trim()
          MiniTrailspace.trim_last_lines()
        end,
        desc = "Trim All",
      },
    },
    config = function()
      require("mini.trailspace").setup()

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lazy", "floggraph", "dashboard" },
        callback = function(data)
          vim.b[data.buf].minitrailspace_disable = true
          vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(ev)
          if vim.g.disable_autoformat or vim.b[ev.buf].disable_autoformat then
            return
          end

          MiniTrailspace.trim()
          MiniTrailspace.trim_last_lines()
        end,
      })
    end,
  },
  {
    "echasnovski/mini.jump2d",
    keys = {
      {
        "<leader>f",
        "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        mode = { "n", "o", "x" },
        desc = "Start 2d jumping",
      },
      {
        "<c-s>",
        function()
          vim.api.nvim_input("<cr>")

          vim.schedule(function()
            local pattern = vim.fn.getreg("/")

            if pattern:sub(1, 2) == [[\<]] and pattern:sub(-2) == [[\>]] then
              pattern = "%f[A-Za-z]" .. pattern:sub(3, -3) .. "%f[^A-Za-z]"
            end

            if pattern:sub(1, 2) == [[\V]] then
              pattern = pattern:sub(3):gsub([[\]], "")
            end

            -- vim.print(pattern)

            MiniJump2d.start({
              allowed_lines = { blank = false, fold = false },
              spotter = MiniJump2d.gen_pattern_spotter(pattern),
            })
          end)
        end,
        mode = { "c" },
        desc = "Start 2d jumping",
      },
    },
    opts = {
      mappings = { start_jumping = "" },
      labels = "asdfghjklqwertyuiopzxcvbnm",
    },
  },
}
