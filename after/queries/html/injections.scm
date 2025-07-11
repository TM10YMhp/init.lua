;extends

;; ================ alpine ================

;; alpine javascript injection
((element
  (start_tag
    (attribute
      (attribute_name) @_name
      (quoted_attribute_value (attribute_value) @injection.content))))
  (#match? @_name "x-(data|init|show|bind|on|text|html|model|modelable|for|effect|ref|teleport|if|id)")
  (#set! injection.language "javascript"))

;; alpine javascript injection
((element
  (start_tag
    (attribute
      (attribute_name) @_name
      (quoted_attribute_value (attribute_value) @injection.content))))
  (#match? @_name "^:")
  (#set! injection.language "javascript"))
