-- query
local javascript_comment_query = [=[
;; comment {name} injection
((comment) @comment
  (#match? @comment "{match}")
  (#set! injection.language "{name}")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))
]=]

-- query
local javascript_block_comment_query = [=[
;; block comment {name} injection
((comment) @comment
  (#match? @comment "{match}")
  (#set! injection.language "{name}")
  .
  (template_string
    (string_fragment) @injection.content))
]=]

return {
  comment = {
    vars = {
      { name = "sql", match = "^//+( )*sql(\\s|$)" },
      { name = "javascript", match = "^// (javascript|js)(\\s|$)" },
      { name = "typescript", match = "^// (typescript|ts)(\\s|$)" },
      { name = "html", match = "^//+( )*html(\\s|$)" },
      { name = "css", match = "^//+( )*css(\\s|$)" },
      { name = "python", match = "^//+( )*(python|py)(\\s|$)" },
    },
    query = javascript_comment_query,
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
    query = javascript_block_comment_query,
  },
}
