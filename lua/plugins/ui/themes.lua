-- Themery and themes
return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("oldworld").setup({
                variant = "oled"
            })

            vim.cmd("colorscheme oldworld")
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
