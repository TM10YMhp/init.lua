return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v3.x",
  event = function()
    for _, value in ipairs(vim.fn.argv()) do
      if vim.fn.isdirectory(value) == 1 then
        return { "BufEnter" }
      end
    end
    return { "BufAdd" }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>se",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          -- dir = vim.loop.cwd(),
        })
      end,
      desc = "Explorer NeoTree",
    },
    {
      "<leader>sE",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.fn.expand("%:p:h"),
        })
      end,
      desc = "Explorer NeoTree in current file",
    },
    {
      "<leader>ge",
      "<cmd>Neotree toggle git_status<cr>",
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      "<cmd>Neotree toggle buffers<cr>",
      desc = "Buffer Explorer",
    },
  },
  opts = {
    popup_border_style = "single",
    -- enable_git_status = false,
    -- enable_diagnostics = false,
    -- use_popups_for_input = false,
    resize_timer_interval = 1500,
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        { source = "filesystem", display_name = " Files " },
        { source = "buffers", display_name = " Buffers " },
        { source = "git_status", display_name = " Git " },
        { source = "document_symbols", display_name = " Symbols " },
      },
      tabs_layout = "center",
      separator = "|",
    },
    default_component_configs = {
      container = { enable_character_fade = false },
      indent = {
        padding = 0,
        expander_collapsed = ">",
        expander_expanded = "v",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
      name = { trailing_slash = true },
      git_status = {
        -- stylua: ignore
        symbols = {
          -- Change type
          added     = "",
          modified  = "",
          deleted   = "D",
          renamed   = "R",
          -- Status type
          untracked = "U",
          ignored   = "I",
          unstaged  = "M",
          staged    = "A",
          conflict  = "C",
        },
      },
      -- stylua: ignore start
      file_size      = { enabled = true, required_width = 64 },
      type           = { enabled = true, required_width = 122 },
      last_modified  = { enabled = true, required_width = 88 },
      created        = { enabled = true, required_width = 110 },
      symlink_target = { enabled = false },
      -- stylua: ignore end
    },
    window = { position = "right", width = 33 },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      },
      follow_current_file = { enabled = true, leave_dirs_open = true },
      window = {
        mappings = {
          ["space"] = "none",
          ["/"] = "none",
          ["P"] = {
            "toggle_preview",
            config = { use_float = false, use_image_nvim = false },
          },
        },
      },
      -- NOTE: libuv crash in Windows
      use_libuv_file_watcher = false,
      bind_to_cwd = true,
    },
  },
  config = function(_, opts)
    local function on_move(data)
      SereneNvim.lsp.on_rename(data.source, data.destination)
    end

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })

    -- HACK: remove icons
    local default_renderers = require("neo-tree.defaults").renderers
    table.remove(default_renderers.directory, 2)
    table.remove(default_renderers.file, 2)
    opts.renderers = {
      directory = default_renderers.directory,
      file = default_renderers.file,
    }

    require("neo-tree").setup(opts)
  end,
}
