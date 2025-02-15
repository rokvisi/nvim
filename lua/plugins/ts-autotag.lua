-- Autopairs html tags.

---@type LazySpec
return {
    'windwp/nvim-ts-autotag',
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
