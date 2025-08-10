;extends

;; ================ comment ================

;; comment sql injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "^//+( )*sql(\\s|$)")
  (#set! injection.language "sql"))

;; comment javascript injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "^// (javascript|js)(\\s|$)")
  (#set! injection.language "javascript"))

;; comment typescript injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "^// (typescript|ts)(\\s|$)")
  (#set! injection.language "typescript"))

;; comment html injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "^//+( )*html(\\s|$)")
  (#set! injection.language "html"))

;; comment css injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "^//+( )*css(\\s|$)")
  (#set! injection.language "css"))

;; comment python injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "^//+( )*(python|py)(\\s|$)")
  (#set! injection.language "python"))
