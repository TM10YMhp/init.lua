;extends

;; ================ comment ================

;; comment query injection
(chunk
  (comment) @comment
    local_declaration: (variable_declaration
      (assignment_statement
        (expression_list
          value: (string
            content: (string_content) @injection.content))
  (#match? @comment "^--+( )*query(\\s|$)")
  (#set! injection.language "query"))))
