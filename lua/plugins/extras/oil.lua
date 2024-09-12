-- TODO: check this
function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "<leader>sl", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
  opts = {
    default_file_explorer = false,
    columns = {},
    delete_to_trash = false,
    lsp_file_methods = {
      timeout_ms = 3000,
      autosave_changes = false,
    },
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      -- ["<C-s>"] = "actions.select_vsplit",
      -- ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["q"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      -- ["g\\"] = "actions.toggle_trash",
    },
    use_default_keymaps = false,
    view_options = {
      show_hidden = true,
    },
    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
    float = {
      border = "single",
    },
    preview = {
      border = "single",
    },
    progress = {
      border = "single",
    },
    keymaps_help = {
      border = "single",
    },
  },
}
