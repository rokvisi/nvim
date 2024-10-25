-- Themery and themes
return {
    -- Default Theme
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,

        config = function()
            vim.cmd("colorscheme kanagawa")
        end
    },
    {
        'zaldih/themery.nvim',
        lazy = true,
        opts = {
            themes = {
                "kanagawa"
            }
        }
    }
}

