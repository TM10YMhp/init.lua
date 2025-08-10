local M = {}

-- query
M.lua_comment = [=[
;; local comment {name} injection
(chunk
  (comment
    content: (comment_content) @comment)
  local_declaration: (variable_declaration
    (assignment_statement
      (expression_list
        value: (string
          content: (string_content) @injection.content))
      (#match? @comment "{match}")
      (#set! injection.language "{name}"))))

;; comment {name} injection
(chunk
  (comment
    content: (comment_content) @comment)
  (assignment_statement
    (expression_list
      value: (string
        content: ((string_content) @injection.content
          (#match? @comment "{match}")
          (#set! injection.language "{name}"))))))
]=]

-- query
M.javascript_comment = [=[
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
M.javascript_block_comment = [=[
;; block comment {name} injection
((comment) @comment
  (#match? @comment "{match}")
  (#set! injection.language "{name}")
  .
  (template_string
    (string_fragment) @injection.content))
]=]

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
