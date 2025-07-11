_G.SereneNvim = require("util")

require("config") --.init()

require("config.options") -- call before lazy.nvim
require("config.autocmds") -- check BufReadPost

SereneNvim.hacks.enable() -- use before load plugins

require("config.lazy")
