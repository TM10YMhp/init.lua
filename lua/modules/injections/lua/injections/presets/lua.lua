-- query
local lua_comment_query = [=[
;; comment {name} injection
((comment
  (comment_content) @comment)
  (#match? @comment "{match}")
  (#set! injection.language "{name}")
  .
  [
    (assignment_statement
      (expression_list
        value: (string
          content: (string_content) @injection.content)))
    (variable_declaration
      (assignment_statement
        (expression_list
          value: (string
            content: (string_content) @injection.content))))
  ])
]=]

return {
  comment = {
    vars = {
      { name = "query", match = " query(\\s|$)" },
    },
    query = lua_comment_query,
  },
}
