;extends

;; ================ comment ================

;; local comment query injection
(chunk
  (comment
    content: (comment_content) @comment)
  local_declaration: (variable_declaration
    (assignment_statement
      (expression_list
        value: (string
          content: (string_content) @injection.content))
      (#match? @comment "( )*query(\\s|$)")
      (#set! injection.language "query"))))

;; comment query injection
(chunk
  (comment
    content: (comment_content) @comment)
  (assignment_statement
    (expression_list
      value: (string
        content: ((string_content) @injection.content
          (#match? @comment "( )*query(\\s|$)")
          (#set! injection.language "query"))))))
