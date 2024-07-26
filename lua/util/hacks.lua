local M = {}

-- toggle codeium
function M.codeium()
  -- https://github.com/Exafunction/codeium.nvim/issues/136
  local mod = require("codeium.source")

  local is_available = mod.is_available
  ---@diagnostic disable-next-line: duplicate-set-field
  function mod:is_available()
    return is_available(self) and vim.g.codeium_enabled
  end
end

-- fix windows path
function M.telescope()
  local mod = require("telescope.actions.state")
  local get_selected_entry = mod.get_selected_entry
  ---@diagnostic disable-next-line: duplicate-set-field
  mod.get_selected_entry = function()
    local entry = get_selected_entry()
    if entry.path then
      entry.path = entry.path:gsub("/", "\\")
    end
    return entry
  end
end

-- disabled nvim-cmp for command mode wildmenu
function M.cmp()
  -- https://github.com/hrsh7th/nvim-cmp/discussions/1731#discussion-5751566
  vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
    pattern = { ":" },
    callback = function()
      local mappings = vim.api.nvim_get_keymap("c")
      for _, v in pairs(mappings) do
        if v.desc == "cmp.utils.keymap.set_map" then
          vim.keymap.del("c", v.lhs)
        end
      end
    end,
  })
end

-- check if directory exists
function M.project()
  local mod = require("project_nvim.utils.path")
  local exists = mod.exists
  ---@diagnostic disable-next-line: duplicate-set-field
  mod.exists = function(path)
    path = path:gsub("\\", "/")
    return vim.fn.isdirectory(path) == 1 or exists(path)
  end
end

function M.luasnip()
  -- https://github.com/L3MON4D3/LuaSnip/issues/656
  local mod = require("luasnip")
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup(
      "tm10ymhp_unlink_snippet_on_mode_change",
      { clear = true }
    ),
    pattern = { "s:n", "i:*" },
    desc = "Forget the current snippet when leaving the insert mode",
    callback = function(evt)
      -- if we have n active nodes, n - 1 will still remain after a
      -- `unlink_current()` call. We unlink all of them by wrapping the calls
      -- in a loop.
      while true do
        if
          mod.session
          and mod.session.current_nodes[evt.buf]
          and not mod.session.jump_active
        then
          mod.unlink_current()
        else
          break
        end
      end
    end,
  })
end

-- only run in http filetype
function M.rest()
  local mod = require("rest-nvim")
  local message = table.concat({
    'RestNvim is only available for filetype "http"',
    'Current filetype is "' .. vim.bo.filetype .. '"',
  }, "\n")

  local run = mod.run
  mod.run = function(...)
    if vim.bo.filetype == "http" then
      return run(...)
    end

    SereneNvim.warn(message)
  end

  local last = mod.last
  mod.last = function(...)
    if vim.bo.filetype == "http" then
      return last(...)
    end

    SereneNvim.warn(message)
  end
end

function M.conceallevel()
  local mod = vim.lsp.util
  local open_floating_preview = mod.open_floating_preview
  mod.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.max_width = 80
    opts.max_height = 35
    opts.style = "minimal"
    opts.border = "single"

    local bufnr, winid = open_floating_preview(contents, syntax, opts, ...)
    vim.wo[winid].conceallevel = 0

    return bufnr, winid
  end
end

-- detect jsconfig.json
function M.tsc()
  local mod = require("tsc.utils")

  local find_nearest_tsconfig = mod.find_nearest_tsconfig
  mod.find_nearest_tsconfig = function()
    find_nearest_tsconfig()

    local jsconfig = vim.fn.findfile("jsconfig.json", ".;")
    return jsconfig ~= "" and { jsconfig } or {}
  end

  local find_tsc_bin = mod.find_tsc_bin
  mod.find_tsc_bin = function()
    local tsc_bin = find_tsc_bin()

    if tsc_bin == "tsc" then
      return vim.fn.exepath("tsc")
    end

    return tsc_bin
  end
end

-- remove icons
function M.neo_tree()
  local mod = require("neo-tree.defaults")
  table.remove(mod.renderers.directory, 2)
  table.remove(mod.renderers.file, 2)
end

-- pretty info
function M.conform()
  local mod = require("conform.health")
  local show_window = mod.show_window

  mod.show_window = function()
    show_window()

    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_config(win, { border = "single" })
    vim.wo[win].wrap = true
  end
end

return M
