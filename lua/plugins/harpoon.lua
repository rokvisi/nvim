-- Quickly jump between marked files.

---@type LazySpec
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
    keys = {
        -- Find harpoon marks.
        {
            "<leader>fh",
            function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
            desc = "[f]ind [h]arpoon marks",
        },

        -- Generic add, remove, next, previous.
        {
            "<leader>hA",
            function() require("harpoon"):list():add() end,
            desc = "[h]arpoon [A]dd",
        },
        {
            "<leader>hD",
            function() require("harpoon"):list():remove() end,
            desc = "[h]arpoon [D]elete",
        },
        {
            "<C-S-P>",
            function() require("harpoon"):list():prev() end,
            desc = "Previous harpoon mark",
        },
        {
            "<C-S-N>",
            function() require("harpoon"):list():next() end,
            desc = "Next harpoon mark",
        },

        -- Go to harpoon marks h, j, k, l
        {
            "<C-h>",
            function() require("harpoon"):list():select(1) end,
            desc = "Go to harpoon mark 1",
        },
        {
            "<C-j>",
            function() require("harpoon"):list():select(2) end,
            desc = "Go to harpoon mark 2",
        },
        {
            "<C-k>",
            function() require("harpoon"):list():select(3) end,
            desc = "Go to harpoon mark 3",
        },
        {
            "<C-l>",
            function() require("harpoon"):list():select(4) end,
            desc = "Go to harpoon mark 4",
        },

        -- Add harpoon marks h, j, k, l.
        {
            "<leader>hah",
            function() require("harpoon"):list():replace_at(1) end,
            desc = "[h]arpoon [a]dd mark 1",
        },
        {
            "<leader>haj",
            function() require("harpoon"):list():replace_at(2) end,
            desc = "[h]arpoon [a]dd mark 2",
        },
        {
            "<leader>hak",
            function() require("harpoon"):list():replace_at(3) end,
            desc = "[h]arpoon [a]dd mark 3",
        },
        {
            "<leader>hal",
            function() require("harpoon"):list():replace_at(4) end,
            desc = "[h]arpoon [a]dd mark 4",
        },

        -- Remove harpoon marks h, j, k, l
        {
            "<leader>hdh",
            function() require("harpoon"):list():remove_at(1) end,
            desc = "[h]arpoon [d]elete mark 1",
        },
        {
            "<leader>hdj",
            function() require("harpoon"):list():remove_at(2) end,
            desc = "[h]arpoon [d]elete mark 2",
        },
        {
            "<leader>hdk",
            function() require("harpoon"):list():remove_at(3) end,
            desc = "[h]arpoon [d]elete mark 3",
        },
        {
            "<leader>hdl",
            function() require("harpoon"):list():remove_at(4) end,
            desc = "[h]arpoon [d]elete mark 4",
        },
    }
}
