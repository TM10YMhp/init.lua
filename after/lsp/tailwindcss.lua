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
      experimental = {
        -- TODO: arrays and objects
        classRegex = {
          -- { "(?:tw|clsx|cn)\\(([^;]*)[\\);]", "[`'\"`]([^'\"`;]*)[`'\"`]" },

          {
            [=[(?:_?[tT]w.*)[\[{]([^;]*)[\]};]]=],
            [=[[`'"`]([^'"`;]*)[`'"`]]=],
          },
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
