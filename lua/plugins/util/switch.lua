return {
  "AndrewRadev/switch.vim",
  cmd = "Switch",
  keys = {
    { "-", "<Plug>(SwitchInLine)", desc = "Switch" },
    { "+", "<Plug>(SwitchReverse)", desc = "Switch Reverse" },
  },
  init = function() vim.g.switch_mapping = "" end,
  config = function()
    vim.api.nvim_exec_autocmds("FileType", { buffer = 0, modeline = false })

    -- https://github.com/AndrewRadev/switch.vim/issues/14
    -- https://github.com/AndrewRadev/switch.vim/wiki/Switch-next-in-current-line
    vim.cmd([[
      nnoremap <silent> <Plug>(SwitchInLine) :<C-u>call SwitchLine(v:count1)<cr>

      fun! SwitchLine(cnt)
        let tick = b:changedtick
        let start = getcurpos()
        for n in range(a:cnt)
          Switch
        endfor
        if b:changedtick != tick
          return
        endif
        while v:true
          let pos = getcurpos()
          normal! w
          if pos[1] != getcurpos()[1] || pos == getcurpos()
            break
          endif
          for n in range(a:cnt)
            Switch
          endfor
          if b:changedtick != tick
            return
          endif
        endwhile
        call setpos('.', start)
      endfun
      ]])
  end,
}
