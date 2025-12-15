-- TODO: fzf_profile alt e
-- TODO: nvim-tree
local get_cwd = function()
  local cwd = vim.fn.expand("%:p:h")

  -- if vim.o.filetype == "neo-tree" then
  --   -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/585
  --   local tree = require("neo-tree.sources.manager").get_state("filesystem").tree
  --   if tree ~= nil then
  --     local node = tree:get_node()
  --     cwd = vim.fn.fnamemodify(node.path, ":p:h")
  --   end
  -- end
  --
  -- if vim.o.filetype == "oil" then
  --   local oil = require("oil")
  --   local entry = oil.get_cursor_entry()
  --   local dir = oil.get_current_dir()
  --
  --   if entry and entry.type == "directory" then dir = dir .. entry.parsed_name end
  --
  --   cwd = vim.fn.fnamemodify(dir, ":p:h")
  -- end
  --
  -- if vim.o.filetype == "NvimTree" then
  --   local tree = require("nvim-tree.api").tree.get_node_under_cursor()
  --   if tree ~= nil then cwd = vim.fn.fnamemodify(tree.absolute_path, ":p:h") end
  -- end

  if vim.o.filetype == "snacks_picker_list" then
    local item = Snacks.picker.get()[1]:current()
    cwd = vim.fn.fnamemodify(item._path, ":p:h")
  end

  return cwd
end

return {
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      -- lsp
      {
        "<leader>xx",
        function() Snacks.picker.diagnostics_buffer() end,
        desc = "Buffer Diagnostics",
      },
      { "<leader>xX", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      {
        "<leader>xi",
        function() Snacks.picker.lsp_implementations() end,
        desc = "Implementations",
      },
      {
        "<leader>xd",
        function() Snacks.picker.lsp_definitions({ auto_confirm = false }) end,
        desc = "Definitions",
      },
      { "<leader>xD", function() Snacks.picker.lsp_definitions() end, desc = "Definitions (jump)" },
      {
        "<leader>xt",
        function() Snacks.picker.lsp_type_definitions() end,
        desc = "Type Definitions",
      },
      { "<leader>xr", function() Snacks.picker.lsp_references() end, desc = "References" },
      { "<leader>xs", function() Snacks.picker.lsp_symbols() end, desc = "Symbols" },
      {
        "<leader>xS",
        function() Snacks.picker.lsp_workspace_symbols() end,
        desc = "Workspace Symbols",
      },
      --
      { "<leader>xR", function() Snacks.picker.grep_word() end, desc = "Grep Word" },
      {
        "<leader>xR",
        function() Snacks.picker.grep_word() end,
        desc = "Grep Word",
        mode = { "v" },
      },
      { "<leader>sw", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      {
        "<leader>sL",
        function() Snacks.picker.files({ cwd = vim.fn.stdpath("data") .. "/" .. "lazy" }) end,
        desc = "Find Files (lazy)",
      },
      {
        "<leader>sl",
        function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
        desc = "Find Files (config)",
      },
      { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files (root)" },
      {
        "<leader>sF",
        function() Snacks.picker.files({ cwd = get_cwd() }) end,
        desc = "Find Files (cwd)",
      },
      { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      {
        "<leader>sB",
        function() Snacks.picker.buffers({ hidden = true, nofile = true }) end,
        desc = "Buffers (all)",
      },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      {
        "<leader>sG",
        function() Snacks.picker.grep({ cwd = get_cwd() }) end,
        desc = "Fzf Live Grep (cwd)",
      },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocommands" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume" },
      {
        "<leader>sk",
        function() Snacks.picker.keymaps({ plug = false, title = "User Keymaps" }) end,
        desc = "Keymaps",
      },
      { "<leader>sK", function() Snacks.picker.keymaps() end, desc = "Keymaps (all)" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      -- git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- more
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo" },
      { "<leader>sz", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
      { "<leader>sS", function() Snacks.picker.spelling() end, desc = "Spelling" },
    },
    opts = {
      picker = {
        previewers = {
          diff = {
            style = "terminal",
          },
        },
        sources = {
          files = {
            hidden = true,
            ignored = false,
            follow = true,
          },
          explorer = {
            layout = {
              cycle = false,
              layout = { position = "right" },
            },
            win = {
              list = {
                keys = {
                  ["]w"] = false,
                  ["[w"] = false,
                  ["]e"] = false,
                  ["[e"] = false,
                },
              },
            },
          },
        },
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0.8,
              min_width = 120,
              height = 0.85,
              {
                box = "vertical",
                border = "single",
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                title = "{preview}",
                border = "single",
                width = 0.5,
              },
            },
          },
          vertical = {
            layout = {
              backdrop = false,
              width = 0.5,
              min_width = 80,
              height = 0.85,
              min_height = 30,
              box = "vertical",
              border = "single",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
              {
                win = "preview",
                title = "{preview}",
                height = 0.5,
                border = "top",
              },
            },
          },
          sidebar = {
            layout = {
              backdrop = false,
              width = 33,
              min_width = 33,
              height = 0,
              position = "left",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "single",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              {
                win = "preview",
                title = "{preview}",
                height = 0.4,
                border = "top",
              },
            },
          },
        },
        prompt = "> ",
        win = {
          list = { wo = { foldcolumn = "0" } },
          preview = {
            wo = {
              signcolumn = "no",
              foldcolumn = "0",
            },
          },
        },
        icons = {
          files = { enabled = false },
          tree = {
            middle = "│ ",
          },
          undo = { saved = "[+] " },
          ui = {
            live = "L ",
            hidden = "h",
            ignored = "i",
            follow = "f",
            selected = "● ",
            unselected = "○ ",
          },
          git = { enabled = false },
          diagnostics = {
            Error = "E ",
            Warn = "W ",
            Hint = "H ",
            Info = "I ",
          },
        },
      },
    },
  },
}
