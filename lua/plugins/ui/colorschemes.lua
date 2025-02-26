-- Color schemes

---@type LazySpec
return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {},
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({})
            require("tokyonight").load({ style = "night" })
        end
    }
}
