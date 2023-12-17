return {
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
        pattern = 'lazy',
        callback = function(data)
          vim.b[data.buf].minitrailspace_disable = true
          vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
        end,
      })
    end
  },
  {
    "echasnovski/mini.tabline",
    event = "VeryLazy",
    opts = {
      show_icons = false,
      set_vim_settings = false,
      tabpage_section = 'right'
    },
    config = function(_, opts)
      require('mini.tabline').setup(opts)

      vim.opt.showtabline = 2
    end
  },
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
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
    "echasnovski/mini.ai",
    event = "VeryLazy",
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
    "echasnovski/mini.jump",
    event = "VeryLazy",
    opts = { delay = { highlight = 0 } }
  },
  {
    "echasnovski/mini.jump2d",
    keys = {
      {
        "<cr>",
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
    "echasnovski/mini.align",
    event = "VeryLazy",
    opts = {}
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {}
  },
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>E",
        "<cmd>lua MiniFiles.open(vim.fn.expand('%:p:h'))<CR>",
        desc = "Create files"
      }
    },
    config = function()
      local my_prefix = function(fs_entry)
        if fs_entry.fs_type == 'directory' then
          return '/', 'MiniFilesDirectory'
        end
        return
      end

      require('mini.files').setup({
        content = {
          prefix = my_prefix
        },
        options = {
          use_as_default_explorer = false,
        },
      })

      local open_split = function(direction)
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
      end

      local open_split_horizontal = function()
        open_split('belowright horizontal')
      end

      local open_split_vertical = function()
        open_split('belowright vertical')
      end

      local toggle_preview = function()
        local width_preview = vim.o.columns - 55
        local refresh_preview = function(value)
          MiniFiles.refresh({
            windows = { preview = value, width_preview = width_preview },
          })
          vim.b.mini_files_preview_opened = value
        end
        if vim.b.mini_files_preview_opened then
          refresh_preview(false)
          MiniFiles.trim_right()
        else
          refresh_preview(true)
        end
      end

      local custom_go_in_plus = function()
        for _ = 1, vim.v.count1 - 1 do
          MiniFiles.go_in()
        end
        local fs_entry = MiniFiles.get_fs_entry()
        local is_at_file = fs_entry ~= nil and fs_entry.fs_type == 'file'
        MiniFiles.go_in()
        if is_at_file then
          MiniFiles.close()
        else
          MiniFiles.trim_left()
        end
      end

      local custom_go_out_plus = function()
        for _ = 1, vim.v.count1 do
          MiniFiles.go_out()
        end
        MiniFiles.trim_right()
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          local map = function(lhs, rhs, desc)
            local opts = { buffer = buf_id, desc = desc }
            vim.keymap.set('n', lhs, rhs, opts)
          end

          map('gs', open_split_horizontal, 'Open belowright horizontal')
          map('gv', open_split_vertical, 'Open belowright vertical')
          map('<c-p>', toggle_preview, 'Toggle preview')
          map('<tab>', toggle_preview, 'Toggle preview')
          map('<s-tab>', toggle_preview, 'Toggle preview')
          map('<cr>', custom_go_in_plus, 'Custom go in plus')
          map('-', custom_go_out_plus, 'Custom go out plus')
        end,
      })
    end
  },
}
