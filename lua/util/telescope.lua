---@class serenenvim.util.telescope
local M = {}

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
M.open_selected = function(prompt_bufnr)
  local actions = require("telescope.actions")

  local picker =
    require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local selected = picker:get_multi_selection()
  if vim.tbl_isempty(selected) then
    -- local actions_state = require("telescope.actions.state")
    -- local selection = actions_state.get_selected_entry()
    -- vim.print(selection)
    actions.select_default(prompt_bufnr)
  else
    actions.close(prompt_bufnr)
    for _, v in pairs(selected) do
      if v.path then
        vim.cmd(
          "edit"
            .. (v.lnum and " +" .. v.lnum or "")
            .. " "
            .. v.path:gsub("/", "\\")
        )
      end
    end
  end
end

M.open_all = function(prompt_bufnr)
  local actions = require("telescope.actions")

  local picker =
    require("telescope.actions.state").get_current_picker(prompt_bufnr)

  local manager = picker.manager
  if manager:num_results() > 15 then
    SereneNvim.warn("Too many results, limiting to 15")
    return
  end

  -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua#L910
  local from_entry = require("telescope.from_entry")
  local entries = {}
  for entry in manager:iter() do
    table.insert(entries, from_entry.path(entry, false, false))
  end

  if vim.tbl_isempty(entries) then
    SereneNvim.warn("No results")
  else
    actions.close(prompt_bufnr)
    for _, v in pairs(entries) do
      vim.cmd("edit" .. " " .. v:gsub("/", "\\"))
    end
  end
end

M.neotree_navigate = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local actions_state = require("telescope.actions.state")

  actions.close(prompt_bufnr)

  vim.defer_fn(function()
    local selection = actions_state.get_selected_entry()

    require("neo-tree.command").execute({
      reveal_file = selection.path,
    })
  end, 100)
end

-- https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/382
M.open_using_file_browser = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local actions_state = require("telescope.actions.state")

  actions.close(prompt_bufnr)

  local selection = actions_state.get_selected_entry()

  require("telescope").extensions.file_browser.file_browser({
    path = vim.fn.fnamemodify(selection.path, ":h"),
  })
end

return M
