-- Quickly jump between marked files.

-- After a harppon jump to a non-open file - folds don't work until you enter insert mode. Possible harpoon bug.
local function harpoon_select(nr)
    require("harpoon"):list():select(nr)
    vim.cmd("UfoEnableFold")
end

---@type LazySpec
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
    keys = {
        -- Generic add, remove, next, previous.
        { "<C-S-P>",     function() require("harpoon"):list():prev() end,        desc = "Previous harpoon mark" },
        { "<C-S-N>",     function() require("harpoon"):list():next() end,        desc = "Next harpoon mark" },

        -- Go to harpoon marks h, j, k, l
        { "<C-h>",       function() harpoon_select(1) end,                       desc = "Go to harpoon mark 1" },
        { "<C-j>",       function() harpoon_select(2) end,                       desc = "Go to harpoon mark 2" },
        { "<C-k>",       function() harpoon_select(3) end,                       desc = "Go to harpoon mark 3" },
        { "<C-l>",       function() harpoon_select(4) end,                       desc = "Go to harpoon mark 4" },

        -- Add harpoon marks h, j, k, l.
        { "<leader>hah", function() require("harpoon"):list():replace_at(1) end, desc = "[h]arpoon [a]dd mark 1" },
        { "<leader>haj", function() require("harpoon"):list():replace_at(2) end, desc = "[h]arpoon [a]dd mark 2" },
        { "<leader>hak", function() require("harpoon"):list():replace_at(3) end, desc = "[h]arpoon [a]dd mark 3" },
        { "<leader>hal", function() require("harpoon"):list():replace_at(4) end, desc = "[h]arpoon [a]dd mark 4" },

        -- Remove harpoon marks h, j, k, l
        { "<leader>hdh", function() require("harpoon"):list():remove_at(1) end,  desc = "[h]arpoon [d]elete mark 1" },
        { "<leader>hdj", function() require("harpoon"):list():remove_at(2) end,  desc = "[h]arpoon [d]elete mark 2" },
        { "<leader>hdk", function() require("harpoon"):list():remove_at(3) end,  desc = "[h]arpoon [d]elete mark 3" },
        { "<leader>hdl", function() require("harpoon"):list():remove_at(4) end,  desc = "[h]arpoon [d]elete mark 4" },
    }
}
