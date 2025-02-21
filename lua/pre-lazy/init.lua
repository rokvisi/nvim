-- Replace vim print with 'snacks.debug.inspect' for debugging.
_G.dd = function(...)
    Snacks.debug.inspect(...)
end
_G.bt = function()
    Snacks.debug.backtrace()
end
vim.print = _G.dd

require("pre-lazy.opts")
require("pre-lazy.keymaps")
