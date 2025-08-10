local query = require("injections.query")

local M = {}

M.template = {
  lua = {
    comment = {
      vars = {
        { name = "query", match = "( )*query(\\s|$)" },
      },
      query = query.lua_comment,
    },
  },
  javascript = {
    comment = {
      vars = {
        { name = "sql", match = "^//+( )*sql(\\s|$)" },
        { name = "javascript", match = "^// (javascript|js)(\\s|$)" },
        { name = "typescript", match = "^// (typescript|ts)(\\s|$)" },
        { name = "html", match = "^//+( )*html(\\s|$)" },
        { name = "css", match = "^//+( )*css(\\s|$)" },
        { name = "python", match = "^//+( )*(python|py)(\\s|$)" },
      },
      query = query.javascript_comment,
    },
    block_comment = {
      vars = {
        { name = "javascript", match = "/\\* (js|javascript) \\*/" },
        { name = "typescript", match = "/\\* (ts|typescript) \\*/" },
        { name = "css", match = "/\\*( )*css( )*\\*/" },
        { name = "sql", match = "/\\*( )*sql( )*\\*/" },
        { name = "html", match = "/\\*( )*html( )*\\*/" },
        { name = "python", match = "/\\*( )*(py|python)( )*\\*/" },
      },
      query = query.javascript_block_comment,
    },
  },
  typescript = {
    extend = { "javascript" },
  },
  rust = {
    extend = {
      "javascript.comment",
    },
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
