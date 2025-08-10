;extends

;; ================ comment ================

;; comment sql injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "^#+( )*sql(\\s|$)")
      (#set! injection.language "sql")))))

;; comment javascript injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "^#+( )*(javascript|js)(\\s|$)")
      (#set! injection.language "javascript")))))

;; comment typescript injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "^#+( )*(typescript|ts)(\\s|$)")
      (#set! injection.language "typescript")))))

;; comment html injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "^#+( )*html(\\s|$)")
      (#set! injection.language "html")))))

;; comment css injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "^#+( )*css(\\s|$)")
      (#set! injection.language "css")))))

;; comment python injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "^#+( )*(python|py)(\\s|$)")
      (#set! injection.language "python")))))
