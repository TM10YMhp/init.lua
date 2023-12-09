return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  config = function()

    --[[
    Here is a non-exhaustive list of the status of popular terminal
    emulators regarding OSC52  (https://github.com/ojroques/vim-oscyank)

    If you are using tmux, run these steps first: enabling OSC52 in tmux.
    Then make sure set-clipboard is set to on: set -s set-clipboard on.
    ]]

    local osc52 = require('osc52')
    osc52.setup {
      max_length = 0, --Maximum length of selection (0 for no limit)
      silent = false, --Disable message on successful copy
      trim = false,   --Trim text before copy
    }
    vim.keymap.set('x', '<leader>y', osc52.copy_visual)
  end
}
