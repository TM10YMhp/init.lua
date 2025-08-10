local M = {}

-- TODO: check rest!!!

-- query
M.python_comment = [=[
;; comment {name} injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "{match}")
      (#set! injection.language "{name}")))))
]=]

-- query
M.rust_comment = [=[
;; comment {name} injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
M.html_alpine = [=[
;; alpine {name} injection
((element
  (start_tag
    (attribute
      (attribute_name) @_name
      (quoted_attribute_value (attribute_value) @injection.content))))
  (#match? @_name "{match}")
  (#set! injection.language "{name}"))
]=]

return M
