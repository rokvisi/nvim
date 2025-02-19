---@type LazySpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        dashboard = {
            enabled = true,
            sections = {
                {
                    section = "terminal",
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
        notifier = {},
        picker = {},
        indent = {
            animate = { enabled = false }
        },
        explorer = {
            replace_netrw = true,
        },
    },
    keys = {
        {
            "<leader>ff",
            function() Snacks.picker.files() end,
            desc = "Find Files",
        },
        {
            "<leader>fb",
            function() Snacks.picker.buffers() end,
            desc = "Buffers",
        },
        {
            "<leader>fg",
            function() Snacks.picker.grep() end,
            desc = "Grep",
        },
        {
            "<leader>f:",
            function() Snacks.picker.command_history() end,
            desc = "Command History",
        },
        {
            "<leader>fe",
            function() Snacks.explorer() end,
            desc = "File Explorer",
        },
        {
            "<leader>fc",
            function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
            desc = "Find Config File",
        },
    },
}
