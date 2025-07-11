;extends

;; ================ comment ================

;; comment sql injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "^//+( )*sql(\\s|$)")
  (#set! injection.language "sql"))

;; comment javascript injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "^//+( )*(javascript|js)(\\s|$)")
  (#set! injection.language "javascript"))

;; comment typescript injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "^//+( )*(typescript|ts)(\\s|$)")
  (#set! injection.language "typescript"))

;; comment html injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "^//+( )*html(\\s|$)")
  (#set! injection.language "html"))

;; comment css injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "^//+( )*css(\\s|$)")
  (#set! injection.language "css"))

;; comment python injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "^//+( )*(python|py)(\\s|$)")
  (#set! injection.language "python"))

;; ================ block_comment ================

;; variable css injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "/\\*( )*css( )*\\*/")
  (#set! injection.language "css"))

;; argument css injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "/\\*( )*css( )*\\*/")
  (#set! injection.language "css"))

;; variable sql injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "/\\*( )*sql( )*\\*/")
  (#set! injection.language "sql"))

;; argument sql injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "/\\*( )*sql( )*\\*/")
  (#set! injection.language "sql"))

;; variable typescript injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "/\\*( )*(ts|typescript)( )*\\*/")
  (#set! injection.language "typescript"))

;; argument typescript injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "/\\*( )*(ts|typescript)( )*\\*/")
  (#set! injection.language "typescript"))

;; variable javascript injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "/\\*( )*(js|javascript)( )*\\*/")
  (#set! injection.language "javascript"))

;; argument javascript injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "/\\*( )*(js|javascript)( )*\\*/")
  (#set! injection.language "javascript"))

;; variable html injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "/\\*( )*html( )*\\*/")
  (#set! injection.language "html"))

;; argument html injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "/\\*( )*html( )*\\*/")
  (#set! injection.language "html"))

;; variable python injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "/\\*( )*(py|python)( )*\\*/")
  (#set! injection.language "python"))

;; argument python injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "/\\*( )*(py|python)( )*\\*/")
  (#set! injection.language "python"))

;; ================ string ================

;; string sql injection
((string_fragment) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*--+( )*sql")
  (#set! injection.language "sql"))

;; string javascript injection
((string_fragment) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*//+( )*(javascript|js)")
  (#set! injection.language "javascript"))

;; string typescript injection
((string_fragment) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*//+( )*(typescript|ts)")
  (#set! injection.language "typescript"))

;; string html injection
((string_fragment) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*\\<\\!--( )*html( )*--\\>")
  (#set! injection.language "html"))

;; string css injection
((string_fragment) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*/\\*+( )*css( )*\\*+/")
  (#set! injection.language "css"))

;; string python injection
((string_fragment) @injection.content
  (#match? @injection.content "^(\r\n|\r|\n)*#+( )*py")
  (#set! injection.language "python"))
