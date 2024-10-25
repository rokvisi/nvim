vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.maplocalleader = " "
-- Yank text to system clipboard
vim.keymap.set("v", "<S-y>", '"+y', { desc = "Yank to system clipboard" })

-- KASPARAS: remaping down and up for easier navigation in wrapped lines
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })

-- KASPARAS: move selected lines while holding alt
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")

-- KASPARAS: remapping Control-w (h, j, l, k) to only control, to move with splits more easily
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- KASPARAS: easy vertical and horizontal splits
vim.keymap.set("n", "<leader>s", function()
    vim.cmd("vsplit")
end, { desc = "[S]plit window to the right" })
vim.keymap.set("n", "<leader>hs", function()
    vim.cmd("split")
end, { desc = "[H]orizontally [S]plit window" })

--KASPARAS TODO: make resizable splits, I use modkey which is alt for me, IDK how it is on mac
