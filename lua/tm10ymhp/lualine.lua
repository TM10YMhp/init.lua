local M = {}

function M.template_diagnostic(sources)
  return {
    'diagnostics',
    sources = { sources },
    fmt = function(str) return str:gsub(':', '') end
  }
end

function M.lsp_client_names()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()

  if next(clients) == nil then
    return buf_ft
  end
  return '['..#clients..']'..buf_ft
end

function M.cursor_position()
  if
    vim.fn.getfsize(vim.fn.expand('%')) > 1024 * 1024
  then
    return "File too long"
  else
    return '%l:%v|%{virtcol("$")-1}'
  end
end

M.winbar_config = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {
    M.template_diagnostic('nvim_diagnostic'),
    {
      function()
        local data = ''
        local symbol = vim.bo.modified and '* ' or '> '

        if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
          data = vim.fn.expand('%:~:.') or '[No Name]'
        else
          data = vim.fn.expand('%:t')
        end

        if data == '' then
          data = '[No Name]'
        end

        return symbol..data
      end,
      padding = 0,
      color = "Normal"
    }
  },
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
}

M.filesize = {
  'filesize',
  fmt = function(str) return str.upper(str) end
}

return M
