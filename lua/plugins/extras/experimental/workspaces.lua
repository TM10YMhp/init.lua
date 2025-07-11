local function fzf_workspaces()
  local fzf_lua = require("fzf-lua")
  local separator = require("fzf-lua.utils").nbsp
  local workspaces = require("workspaces")

  local transform = function(name, path)
    local normalized_path = SereneNvim.__IS_WINDOWS and path:gsub("/", "\\")
      or path
    return string.format("%-28s%s%s", name, separator, normalized_path)
  end

  local normalize = function(value)
    local value = vim.split(value, separator, { plain = true })[2]
    return vim.trim(value)
  end

  local contents = {}
  local workspace_list = workspaces.get()
  for _, workspace in ipairs(workspace_list) do
    table.insert(contents, transform(workspace.name, workspace.path))
  end

  local opts = {
    actions = {
      ["default"] = function(selected)
        local cwd = normalize(selected[1])
        fzf_lua.files({ cwd = cwd })
      end,
    },
  }

  fzf_lua.fzf_exec(contents, opts)
end

return {
  "natecraddock/workspaces.nvim",
  cmd = "WorkspacesOpen",
  keys = {
    {
      "<leader>sp",
      function() fzf_workspaces() end,
      desc = "Change Workspace",
    },
  },
  opts = {
    -- rooter
    hooks = {
      open = function()
        vim.g.rooter_manual_only = 1

        vim.api.nvim_create_autocmd("BufEnter", {
          once = true,
          callback = function() vim.g.rooter_manual_only = 0 end,
        })
      end,
    },
  },
}
