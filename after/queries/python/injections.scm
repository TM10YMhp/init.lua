;extends

;; ================ string ================

;; string sql injection
((string_content) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*--+( )*sql")
  (#set! injection.language "sql"))

;; string javascript injection
((string_content) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*//+( )*(javascript|js)")
  (#set! injection.language "javascript"))

;; string typescript injection
((string_content) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*//+( )*(typescript|ts)")
  (#set! injection.language "typescript"))

;; string html injection
((string_content) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*\\<\\!--( )*html( )*--\\>")
  (#set! injection.language "html"))

;; string css injection
((string_content) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*/\\*+( )*css( )*\\*+/")
  (#set! injection.language "css"))

;; string python injection
((string_content) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*#+( )*py")
  (#set! injection.language "python"))

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
