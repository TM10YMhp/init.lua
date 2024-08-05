return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      -- TODO: check delay
      spec = {
        { "crc", desc = "camelCase" },
        { "crm", desc = "MixedCase (aka PascalCase)" },
        { "crp", desc = "PascalCase" },
        { "crs", desc = "snake_case" },
        { "cr_", desc = "snake_case" },
        { "cru", desc = "UPPERCASE" },
        { "crU", desc = "UPPERCASE" },
        { "cr-", desc = "kebab-case" },
        { "crk", desc = "dash-case (aka kebab-case)" },
        { "cr.", desc = "dot.case" },
        { "cr ", desc = "space case" },
      },
    },
  },
  {
    "markonm/traces.vim",
    config = function()
      vim.g.traces_substitute_preview = 0
      vim.g.traces_abolish_integration = 1
    end,
  },
  {
    "tpope/vim-abolish",
    cmd = { "S", "Subvert", "Abolish" },
    dependencies = { "markonm/traces.vim" },
    keys = {
      { "cr", desc = "Abolish Coercion" },
      {
        "<leader>uS",
        [[:%S///gc<left><left><left><left>]],
        desc = "Abolish Substitute",
      },
      {
        "<leader>uS",
        [[:S///gc<left><left><left><left>]],
        mode = "x",
        desc = "Abolish Substitute Selection",
      },
    },
  },
}
