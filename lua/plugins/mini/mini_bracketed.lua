return {
  "echasnovski/mini.bracketed",
  keys = {
    { "[", mode = { "n", "x", "o" }, desc = "Backward" },
    { "]", mode = { "n", "x", "o" }, desc = "Forward" },
  },
  -- stylua: ignore
  opts = {
    buffer     = { suffix = 'b', options = {} },
    comment    = { suffix = 'g', options = {} },
    conflict   = { suffix = 'x', options = {} },
    diagnostic = { suffix = 'e', options = {} },
    file       = { suffix = 'f', options = {} },
    indent     = { suffix = 'i', options = { change_type = 'diff'} },
    jump       = { suffix = 'j', options = {} },
    oldfile    = { suffix = 'o', options = {} },
    location   = { suffix = 'l', options = {} },
    quickfix   = { suffix = 'q', options = {} },
    treesitter = { suffix = 't', options = {} },
    undo       = { suffix = 'u', options = {} },
    window     = { suffix = 'w', options = {} },
    yank       = { suffix = 'y', options = {} },
  },
}
