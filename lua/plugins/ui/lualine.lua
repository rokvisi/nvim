-- Custom statusline

---@type LazySpec
return {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            always_show_tabline = false,
            icons_enabled = true,
            theme = 'auto',
            section_separators = '',
            component_separators = '',
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            }
        },
        sections = { -- Sections for active windows
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = {}
        },
        inactive_sections = { -- Sections for inactive windows
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = {}
        },
        -- Can't customize the individual buffer names without writing a custom buffers component.
        -- Using bufferline.nvim instead.
        tabline = {
            -- lualine_a = { 'buffers' },
            -- lualine_b = {},
            -- lualine_c = {},
            -- lualine_x = {},
            -- lualine_y = {},
            -- lualine_z = { 'tabs' }
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
}
