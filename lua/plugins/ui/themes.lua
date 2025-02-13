-- Themery and themes
return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({})
            vim.cmd("colorscheme kanagawa")
        end
    },
    {
        'zaldih/themery.nvim',
        lazy = false,
        opts = {
            themes = {
                "kanagawa",
            },
            livePreview = true
        }
    }
}
