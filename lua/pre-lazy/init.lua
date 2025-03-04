-- Replace vim print with 'snacks.debug.inspect' for debugging.
_G.dd = function(...)
    Snacks.debug.inspect(...)
end
_G.bt = function()
    Snacks.debug.backtrace()
end
vim.print = _G.dd

-- Load neovim options.
require("pre-lazy.opts")

-- Load custom/overriden neovim keymaps.
require("pre-lazy.keymaps")

-- Load custom plugins/code.
require("custom.autoroot")
