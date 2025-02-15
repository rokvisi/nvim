-- Themery and themes
return {
    ---@type LazySpec
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({})
            vim.cmd("colorscheme kanagawa")
        end
    },
    ---@type LazySpec
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
