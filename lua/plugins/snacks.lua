---@type LazySpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        -- explorer = {
        --     replace_netrw = true,
        -- },
        notifier = {},
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        dashboard = {
            enabled = true,
            sections = {
                {
                    section = "terminal",
                    -- cmd = "chafa C:/Users/Rokas/.config/nvim-dash.webp --format symbols --symbols vhalf --size 60x17 --stretch",
                    cmd = "chafa $HOME/.config/nvim-dash.webp --format symbols --symbols vhalf --size 60x17 --stretch",
                    height = 17,
                    padding = 1,
                },
                {
                    pane = 2,
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            },
        },
        picker = {
            -- your picker configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        indent = {
            -- your indent configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            enabled = true,
            chunk = {
                enabled = false,
            },
            animate = {
                enabled = false,
            },
        },
    },
    keys = {
        -- your keymaps configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the keymaps section below

        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>f:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>fe",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
    },
}
