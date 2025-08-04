-- local treesitter_context = {
--   { provider = " " },
--   { provider = "%<" },
--   {
--     provider = function()
--       local winid = vim.api.nvim_get_current_win()
--       local bufnr = vim.api.nvim_win_get_buf(winid)
--
--       local _, ctx_lines =
--         require("treesitter-context.context").get(bufnr, winid)
--
--       if ctx_lines then
--         local res = table.concat(
--           vim.tbl_map(function(item) return vim.trim(item) end, ctx_lines),
--           " "
--         )
--         return "%#Comment#" .. res .. "%#StatusLine#"
--       end
--     end,
--     update = { "CursorMoved", "CursorMovedI" },
--   },
--   { provider = " " },
-- }

return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  -- dependencies = { "nvim-treesitter-context" },
  opts = {
    opts = {
      disable_winbar_cb = function()
        if vim.list_contains({ "fugitiveblame" }, vim.o.filetype) then
          return false
        end

        return vim.fn.win_gettype() == "popup"
          or not vim.list_contains({ "", "help", "acwrite" }, vim.o.buftype)
          or vim.list_contains({ "dashboard" }, vim.o.filetype)
      end,
    },
    statusline = {
      SereneNvim.heirline.git_branch,
      SereneNvim.heirline.git_diff,
      { provider = '%l:%{charcol(".")}|%{charcol("$")-1}' },
      -- treesitter_context,
      { provider = "%=" },
      SereneNvim.heirline.workspace_diagnostic,
      SereneNvim.heirline.lsp_active,
      { provider = " " },
      {
        provider = function()
          return vim.o.expandtab and "s:" .. vim.o.shiftwidth
            or "t:" .. vim.o.tabstop
        end,
      },
      SereneNvim.heirline.file_encoding,
      SereneNvim.heirline.file_format,
      { provider = " " },
      SereneNvim.heirline.file_type,
      SereneNvim.heirline.filesize,
      { provider = " " },
      { provider = "%L" },
    },
    winbar = {
      SereneNvim.heirline.absolute_path,
    },
  },
  config = function(_, opts)
    require("heirline").setup(opts)

    if not opts.opts.disable_winbar_cb() then
      vim.opt_local.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
    end
  end,
}
