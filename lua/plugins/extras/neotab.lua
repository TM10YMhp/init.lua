return {
  "kawre/neotab.nvim",
  event = "InsertEnter",
  opts = {
    tabkey = "<Tab>",
    behavior = "closing",
    smart_punctuators = {
      enabled = true,
      semicolon = {
        enabled = true,
        ft = { "cs", "c", "cpp", "java", "php" },
      },
    },
  },
}
