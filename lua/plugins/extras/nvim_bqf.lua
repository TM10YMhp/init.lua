return {
  {
    "yorickpeterse/nvim-pqf",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      preview = {
        auto_preview = false,
        border = "single",
        delay_syntax = 50,
        win_height = 20,
        winblend = 0,
        show_title = false,
      },
      func_map = {
        open = "<CR>",
        openc = "O",
        drop = "o",
        split = "<C-x>",
        vsplit = "<C-v>",
        tab = "t",
        tabb = "T",
        tabc = "<C-t>",
        tabdrop = "",
        ptogglemode = "zp",
        ptoggleitem = "p",
        ptoggleauto = "P",
        pscrollup = "<C-b>",
        pscrolldown = "<C-f>",
        pscrollorig = "zo",
        prevfile = "<C-p>",
        nextfile = "<C-n>",
        prevhist = "<",
        nexthist = ">",
        lastleave = [['"]],
        stoggleup = "<S-Tab>",
        stoggledown = "<Tab>",
        stogglevm = "<Tab>",
        stogglebuf = [['<Tab>]],
        sclear = "z<Tab>",
        filter = "zn",
        filterr = "zN",
        fzffilter = "zf",
      },
    },
  },
}
