-- Use treesitter to autoclose and autorename html tags

---@type LazySpec
return {
    'windwp/nvim-ts-autotag',
    lazy = false, -- lazy loading is not particularly necessary for this plugin
    opts = {

        -- This nested 'opts' is not a mistake. The plugin expects it.
        opts = {
            -- Defaults
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
        },
    },
}
