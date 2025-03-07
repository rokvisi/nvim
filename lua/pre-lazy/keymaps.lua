-- Shift + y - Yank text to system clipboard.
vim.keymap.set("v", "<S-y>", '"+y', { desc = "Yank to system clipboard" })

-- Remap up/down for easier navigation in text-wrapped lines.
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- No need to release CTRL when switching window focus.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Easier window splits.
vim.keymap.set("n", "<leader>sv", function() vim.cmd("vsplit") end, { desc = "[s]plit window [v]ertically" })
vim.keymap.set("n", "<leader>sh", function() vim.cmd("split") end, { desc = "[s]plit window [h]orizontally" })

--KASPARAS: make resizable splits, I use modkey which is alt for me, IDK how it is on mac
-- TODO: Implement this.

-- Test keybinds.
vim.keymap.set('n', '<leader>tt', require("utils").log_ts_nodes_under_cursor, {
    noremap = true,
    silent = true,
    desc = "[t]est get node [t]ype at cursor"
})
vim.keymap.set('n', '<leader>th', function() Snacks.notifier.hide() end, {
    noremap = true,
    silent = true,
    desc = "[t]est [h]ide all notifications"
})
vim.keymap.set('n', '<leader>ti', function()
    vim.treesitter.inspect_tree({ command = "new" })
end, {
    noremap = true,
    silent = true,
    desc = "[t]est [i]nspect tree"
})

-- NVChad menu.
-- TODO: Add actually usefull options to this.
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
    require('menu.utils').delete_old_menus()

    vim.cmd.exec '"normal! \\<RightMouse>"'

    -- clicked buf
    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

    -- To customize the menu: https://github.com/nvzone/menu/blob/main/lua/menus/default.lua
    require("menu").open({
        {
            name = "Format Buffer",
            cmd = function()
                vim.cmd.Format()
            end,
            rtxt = "<leader>lf",
        }
    }, { mouse = true })
end, {})

-- Delete buffers without disrupting window layout.
vim.keymap.set("n", "<leader>bd", function()
    Snacks.bufdelete()
end)
