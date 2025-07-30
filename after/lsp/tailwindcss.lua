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
      classFunctions = {
        "cva",
        "cx",
        "twMerge",
        "cn",
        "tw",
      },
      -- https://github.com/tailwindlabs/tailwindcss/issues/7553#issuecomment-735915659
      -- https://github.com/tailwindlabs/tailwindcss/discussions/7554
      -- https://github.com/paolotiu/tailwind-intellisense-regex-list
      experimental = {
        -- TODO: arrays and objects
        classRegex = {
          -- { "\\b\\w*Style\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
          -- { "\\b\\w*ClassName\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
          -- { "\\b\\w*ClassNames\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },

          { "classNames:\\s*[\"'`]([^\"'`]*)[\"'`]" },
          {
            "classNames:\\s*\\[([\\s\\S]*?)\\]",
            "\\s*?[\"'`]([^\"'`]*).*?,?\\s?",
          },

          {
            "classNames:\\s*{([\\s\\S]*?)}",
            "\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?",
          },
          {
            "Styles\\s*(?::\\s*[^=]+)?\\s*=\\s*([^;]*);",
            "['\"`]([^'\"`]*)['\"`]",
          },
          -- { "(?:tw|clsx|cn)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },

          -- {
          --   [=[(?:_?[tT]w.*)[\[{]([^;]*)[\]};]]=],
          --   [=[[`'"`]([^'"`;]*)[`'"`]]=],
          -- },
          -- {
          --   [=[(?:className[s]?)[\[{]([^;]*)[\]};]]=],
          --   [=[[`'"`]([^'"`;]*)[`'"`]]=],
          -- },

          -- {
          --   [=[(?:className[s]?)\s*:\s*([^};,]*)[};,]]=],
          --   [=[[`'"]([^'"`]*)[`'"]]=],
          -- },

          -- { "[cC]lassName[s]?\\s*=\\s*{([^}]+)}", '"([^"]*)"' },
          -- {
          --   [=[(?:className[s]?)\s*\:\s*([^;]*),]=],
          --   -- [=[[`"']([^'"`]*)['"`]]=],
          -- },
        },
      },
    },
  },
}
