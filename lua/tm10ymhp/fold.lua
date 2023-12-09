custom_foldtext = function()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart +1
  local _, i = string.find(line, '%S')
  local fill_char = " "
  return fill_char:rep(i-1) .. "... (" .. line_count .. ")"
end
vim.opt.foldtext = 'v:lua.custom_foldtext()'
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

local utils = require('tm10ymhp.utils')

-- https://github.com/tmhedberg/SimpylFold/issues/130#issuecomment-1074049490
vim.api.nvim_create_autocmd('BufRead', {
  desc = 'Update folds',
  callback = function()
    if not utils.is_large_file(vim.fn.expand('%')) then
      vim.api.nvim_create_autocmd('BufWinEnter', {
        once = true,
        command = 'normal! zx'
      })
    end
  end
})
