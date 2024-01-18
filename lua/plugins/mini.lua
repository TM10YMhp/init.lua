return {
  {
    "echasnovski/mini.completion",
    event = "InsertCharPre",
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
  },
  {
    "echasnovski/mini.bracketed",
    keys = {
      { "]", mode = { "n", "x", "o" }, desc = "forward" },
      { "[", mode = { "n", "x", "o" }, desc = "backward" },
    },
    opts = {
      buffer     = { suffix = 'b', options = {} },
      comment    = { suffix = 'c', options = {} },
      conflict   = { suffix = 'x', options = {} },
      diagnostic = { suffix = 'e', options = {} },
      file       = { suffix = 'f', options = {} },
      indent     = { suffix = 'i', options = { change_type = 'diff'} },
      jump       = { suffix = 'j', options = {} },
      location   = { suffix = 'l', options = {} },
      oldfile    = { suffix = 'o', options = {} },
      quickfix   = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      undo       = { suffix = 'u', options = {} },
      window     = { suffix = 'w', options = {} },
      yank       = { suffix = 'y', options = {} },
    }
  },
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align" },
      { "gA", mode = { "n", "x" }, desc = "Align with preview" },
    },
    config = true
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
    config = true
  },
  {
    "echasnovski/mini.trailspace",
    event = "VeryLazy",
    keys = {
      {
        '<leader>ct',
        function()
          MiniTrailspace.trim()
          MiniTrailspace.trim_last_lines()
        end,
        desc = "Trim All"
      }
    },
    config = function()
      require('mini.trailspace').setup()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'lazy', 'floggraph', 'dashboard' },
        callback = function(data)
          vim.b[data.buf].minitrailspace_disable = true
          vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
        end,
      })
    end
  },
  {
    "echasnovski/mini.jump2d",
    keys = {
      {
        "<leader>f",
        "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        mode = { "n", "x" },
        desc = "Start 2d jumping",
      }
    },
    opts = {
      mappings = { start_jumping = "" }
    },
  },
  {
    "echasnovski/mini.jump",
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = 'Jump forward' },
      { "F", mode = { "n", "x", "o" }, desc = 'Jump backward' },
      { "t", mode = { "n", "x", "o" }, desc = 'Jump forward till' },
      { "T", mode = { "n", "x", "o" }, desc = 'Jump backward till' },
    },
    opts = { delay = { highlight = 0 } }
  },
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "o", "x" }, desc = "Around textobject" },
      { "i", mode = { "o", "x" }, desc = "Inside textobject" },
    },
    opts = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter

      return {
        mappings = {
          around_next = '',
          inside_next = '',
          around_last = '',
          inside_last = '',
          goto_left = '',
          goto_right = '',
        },
        n_lines = 500,
        custom_textobjects = {
          -- Need 'nvim-treesitter/nvim-treesitter-textobjects'
          o = spec_treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
          C = spec_treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end
  },
}
