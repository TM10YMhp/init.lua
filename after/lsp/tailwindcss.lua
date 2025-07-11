return {
  settings = {
    tailwindCSS = {
      classAttributes = {
        "class",
        "className",
        "ngClass",
        "classNames",
        "class:list",
        ":class",
      },
      -- https://github.com/tailwindlabs/tailwindcss/issues/7553#issuecomment-735915659
      experimental = {
        classRegex = {
          {
            "(?:cva|cx|twMerge|cn)\\(([^)(]*(?:\\([^)(]*(?:\\([^)(]*(?:\\([^)(]*\\)[^)(]*)*\\)[^)(]*)*\\)[^)(]*)*)\\)",
            -- "\"(.*?)\""
            '"(.*?)"',
          },
          -- "\"([^\"]*)\""
          { "[cC]lassName[s]?\\s*=\\s*{([^}]+)}", '"([^"]*)"' },
          { 'className[s]?\\s*\\:\\s*"([^"]*)"' },
          { "@apply\\s([^;\\n]*)" },
        },
      },
    },
  },
}
