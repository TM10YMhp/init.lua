return {
  "gregorias/coerce.nvim",
  keys = { "cr", { "gCr", mode = { "n", "v" } } },
  init = function()
    vim.g.abolish_no_mappings = 1
  end,
  opts = {
    default_mode_keymap_prefixes = {
      normal_mode = "cr",
      motion_mode = "gCr",
      visual_mode = "gCr",
    },
  },
  config = function(_, opts)
    local coerce = require("coerce")

    coerce.setup(opts)

    coerce.register_case({
      keymap = "m",
      case = require("coerce.case").to_pascal_case,
      description = "MixedCase (aka PascalCase)",
    })
    coerce.register_case({
      keymap = "_",
      case = require("coerce.case").to_snake_case,
      description = "snake_case",
    })
    coerce.register_case({
      keymap = "U",
      case = require("coerce.case").to_upper_case,
      description = "UPPER_CASE",
    })
    coerce.register_case({
      keymap = "-",
      case = require("coerce.case").to_kebab_case,
      description = "dash-case (aka kebab-case)",
    })
    coerce.register_case({
      keymap = ".",
      case = require("coerce.case").to_dot_case,
      description = "dot.case",
    })
    coerce.register_case({
      keymap = " ",
      case = function(str)
        local parts = require("coerce.case").split_keyword(str)
        return table.concat(parts, " ")
      end,
      description = "space case",
    })
  end,
}
