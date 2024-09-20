---@class serenenvim.util.telescope
local M = {}

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
M.open_selected = function(prompt_bufnr)
  local actions = require("telescope.actions")

  local picker =
    require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local selected = picker:get_multi_selection()
  if vim.tbl_isempty(selected) then
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

M.get_telescope_builtin = function(builtin_name, state, path)
  local title = ""
  for str in string.gmatch(builtin_name, "([^" .. "_" .. "]+)") do
    title = title .. str:gsub("^%l", string.upper) .. " "
  end
  title = title:match("^%s*(.*%S)")

  return require("telescope.builtin")[builtin_name]({
    cwd = path,
    prompt_title = title .. " | <CR> Open | <C-s> Navigate",
    file_ignore_patterns = {},
    no_ignore = true,
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local telescope_actions = require("telescope.actions.mt").transform_mod({
        navigate = function()
          actions.close(prompt_bufnr)
          local action_state = require("telescope.actions.state")
          local selection = action_state.get_selected_entry()
          local filename = selection.filename
          if filename == nil then
            filename = selection[1]
          end
          filename = path .. "\\" .. filename
          require("neo-tree.sources.filesystem").navigate(
            state,
            state.path,
            -- TODO: check this
            filename:gsub("/", "\\")
          )
        end,
      })

      map({ "i", "n" }, "<C-s>", telescope_actions.navigate)

      return true
    end,
  })
end

return M
