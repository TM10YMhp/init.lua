return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  opts = {
    winopts = { zindex = 200 },
    show_count = true,
    maxkeys = 5,
    winhl = "FloatBorder:Comment,Normal:Normal,Visual:CursorLine",
    position = "bottom-center",
    keyformat = {
      ["<BS>"] = "BS",
      ["<CR>"] = "CR",
      ["<Space>"] = "Space",
      ["<Up>"] = "Up",
      ["<Down>"] = "Down",
      ["<Left>"] = "Left",
      ["<Right>"] = "Right",
      ["<PageUp>"] = "PageUp",
      ["<PageDown>"] = "PageDown",
      ["<M>"] = "Alt",
      ["<C>"] = "Ctrl",
    },
  },
}
