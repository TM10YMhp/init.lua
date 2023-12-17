-- Here is a non-exhaustive list of the status of popular terminal
-- emulators regarding OSC52  (https://github.com/ojroques/vim-oscyank)
--
-- If you are using tmux, run these steps first: enabling OSC52 in tmux.
-- Then make sure set-clipboard is set to on: set -s set-clipboard on.

return {
  "ojroques/nvim-osc52",
  keys = {
    {
      '<leader>y',
      function() require('osc52').copy_visual() end,
      mode = 'x'
    }
  },
  opts = {
    max_length = 0, --Maximum length of selection (0 for no limit)
    silent = false, --Disable message on successful copy
    trim = false,   --Trim text before copy
  },
  config = function(_, opts)
    require('osc52').setup(opts)
  end
}
