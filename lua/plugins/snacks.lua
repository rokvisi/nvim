-- Various different plugins.

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
        indent = {
            animate = { enabled = false }
        },
        explorer = {
            replace_netrw = true,
        },
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
        {
            "<leader>fh",
            function()
                local harpoon = require("harpoon")
                local harpoon_items = harpoon:list().items

                local picker_items = require("utils").table.map_ipairs(harpoon_items, function(i, item)
                    ---@type snacks.picker.Item
                    return {
                        idx = i,
                        score = i,
                        text = item.value,
                        file = item.value,
                        pos = { item.context.row, item.context.col }
                    }
                end)

                require("snacks").picker({
                    title = "Harpoon Marks",
                    items = picker_items,
                    focus = "list", -- can be "input" or "list",
                    confirm = function(picker, item)
                        -- Use the harpoon API to select the mark.
                        -- This forces the mark to be updated in the case of an invalid row or column.
                        harpoon:list():select(item.idx)
                        picker:close()
                    end
                })
            end,
            desc = "[f]ind [h]arpoon marks",
        },
        {
            "<leader>fd",
            function()
                local files = vim.fn.systemlist('git diff --name-only')
                local picker_items = require("utils").table.map_ipairs(files, function(i, file)
                    ---@type snacks.picker.Item
                    return {
                        idx = i,
                        score = i,
                        text = file,
                        file = file,
                    }
                end)

                require("snacks").picker({
                    title = "Git Diff Files",
                    items = picker_items,
                    focus = "input", -- can be "input" or "list"
                })
            end,
            desc = "[f]ind git [d]iff files",
        },
        { "<leader>Lg", function() Snacks.lazygit() end,     desc = "[L]azy [g]it" },
        { "<leader>Ll", function() Snacks.lazygit.log() end, desc = "[L]azy git [l]og" },
    },
}
