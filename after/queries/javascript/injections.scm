;extends

;; ================ block_comment ================

;; block comment javascript injection
((comment) @comment
  (#match? @comment "/\\* (js|javascript) \\*/")
  (#set! injection.language "javascript")
  .
  (template_string
    (string_fragment) @injection.content))

;; block comment typescript injection
((comment) @comment
  (#match? @comment "/\\* (ts|typescript) \\*/")
  (#set! injection.language "typescript")
  .
  (template_string
    (string_fragment) @injection.content))

;; block comment css injection
((comment) @comment
  (#match? @comment "/\\*( )*css( )*\\*/")
  (#set! injection.language "css")
  .
  (template_string
    (string_fragment) @injection.content))

;; block comment sql injection
((comment) @comment
  (#match? @comment "/\\*( )*sql( )*\\*/")
  (#set! injection.language "sql")
  .
  (template_string
    (string_fragment) @injection.content))

;; block comment html injection
((comment) @comment
  (#match? @comment "/\\*( )*html( )*\\*/")
  (#set! injection.language "html")
  .
  (template_string
    (string_fragment) @injection.content))

;; block comment python injection
((comment) @comment
  (#match? @comment "/\\*( )*(py|python)( )*\\*/")
  (#set! injection.language "python")
  .
  (template_string
    (string_fragment) @injection.content))

;; ================ comment ================

;; comment sql injection
((comment) @comment
  (#match? @comment "^//+( )*sql(\\s|$)")
  (#set! injection.language "sql")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))

;; comment javascript injection
((comment) @comment
  (#match? @comment "^// (javascript|js)(\\s|$)")
  (#set! injection.language "javascript")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))

;; comment typescript injection
((comment) @comment
  (#match? @comment "^// (typescript|ts)(\\s|$)")
  (#set! injection.language "typescript")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))

;; comment html injection
((comment) @comment
  (#match? @comment "^//+( )*html(\\s|$)")
  (#set! injection.language "html")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))

;; comment css injection
((comment) @comment
  (#match? @comment "^//+( )*css(\\s|$)")
  (#set! injection.language "css")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))

;; comment python injection
((comment) @comment
  (#match? @comment "^//+( )*(python|py)(\\s|$)")
  (#set! injection.language "python")
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content))))
