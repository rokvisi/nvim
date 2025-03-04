-- Color schemes

---@type LazySpec
return {
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
