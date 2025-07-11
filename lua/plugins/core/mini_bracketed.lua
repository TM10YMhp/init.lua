return {
  "echasnovski/mini.bracketed",
  keys = {
    { "[", mode = { "n", "x", "o" }, desc = "Backward" },
    { "]", mode = { "n", "x", "o" }, desc = "Forward" },
  },
  -- stylua: ignore
  opts = {
    buffer     = { suffix = '', options = {} },
    comment    = { suffix = 'g', options = {} },
    conflict   = { suffix = 'x', options = {} },
    diagnostic = { suffix = '', options = {} },
    file       = { suffix = 'f', options = {} },
    indent     = { suffix = '', options = { change_type = 'diff' } },
    jump       = { suffix = 'j', options = {} },
    oldfile    = { suffix = 'o', options = {} },
    location   = { suffix = '', options = {} },
    quickfix   = { suffix = '', options = {} },
    treesitter = { suffix = '', options = {} },
    undo       = { suffix = 'u', options = {} },
    window     = { suffix = 'w', options = {} },
    yank       = { suffix = 'y', options = {} },
  },
}
