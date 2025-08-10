local javascript_preset = require("injections.presets.javascript")
local lua_preset = require("injections.presets.lua")
local query = require("injections.query")

local M = {}

M.template = {
  lua = lua_preset,
  javascript = javascript_preset,
  typescript = {
    extend = { "javascript" },
  },
  rust = {
    extend = { "javascript.comment" },
    comment = {
      query = query.rust_comment,
    },
  },
  python = {
    comment = {
      vars = {
        { name = "sql", match = "^#+( )*sql(\\s|$)" },
        { name = "javascript", match = "^#+( )*(javascript|js)(\\s|$)" },
        { name = "typescript", match = "^#+( )*(typescript|ts)(\\s|$)" },
        { name = "html", match = "^#+( )*html(\\s|$)" },
        { name = "css", match = "^#+( )*css(\\s|$)" },
        { name = "python", match = "^#+( )*(python|py)(\\s|$)" },
      },
      query = query.python_comment,
    },
  },
  html = {
    alpine = {
      vars = {
        {
          name = "javascript",
          match = "x-(data|init|show|bind|on|text|html|model|modelable|for|effect|ref|teleport|if|id)",
        },
        { name = "javascript", match = "^:" },
      },
      query = query.html_alpine,
    },
  },
}

return M
