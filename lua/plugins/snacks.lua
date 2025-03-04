-- Various different plugins.

---@type LazySpec
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        dashboard = {
            sections = {
                {
                    pane = 1,
                    section = "terminal",
                    cmd = "chafa $HOME/.config/nvim-dash.webp --symbols vhalf --size 60x17",
                    height = 17,
                    width = 60,
                    padding = 1,
                },
                { section = "startup" },
                {
                    pane = 2,
                    {
                        icon = " ",
                        title = "Keymaps",
                        padding = 1,
                        indent = 2,
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                },
            },
        },
        notifier = {},
        picker = {},
        indent = { animate = { enabled = false } },
        explorer = { replace_netrw = true, },
        lazygit = {},
    },
    keys = {
        { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "[f]ind [f]iles" },
        { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "[f]ind [b]uffers" },
        { "<leader>fg", function() Snacks.picker.grep() end,                                    desc = "[f]ind [g]rep" },
        { "<leader>f:", function() Snacks.picker.command_history() end,                         desc = "[f]ind [:]command history" },
        { "<leader>fe", function() Snacks.explorer() end,                                       desc = "[f]ind [e]xplorer" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[f]ind [c]onfig file" },
        { "<leader>fC", function() Snacks.picker.colorschemes() end,                            desc = "[f]ind [C]olorscheme" },
        { "<leader>fn", function() Snacks.picker.notifications() end,                           desc = "[f]ind [n]notification" },
        { "<leader>fH", function() Snacks.picker.help() end,                                    desc = "[f]ind [H]elp" },
        { "<leader>fx", function() Snacks.picker.diagnostics_buffer() end,                      desc = "[f]ind diagnosti[x]s" },
        { "<leader>fh", require("custom.pickers").find_harpoon_marks,                           desc = "[f]ind [h]arpoon marks", },
        { "<leader>fd", require("custom.pickers").find_git_diff_files,                          desc = "[f]ind git [d]iff files" },
        { "<leader>fs", require("custom.pickers").find_svelte_route_files,                      desc = "[f]ind [s]velte route files" },
        { "<leader>Lg", function() Snacks.lazygit() end,                                        desc = "[L]azy [g]it" },
        { "<leader>Ll", function() Snacks.lazygit.log() end,                                    desc = "[L]azy git [l]og" },
    },
}
