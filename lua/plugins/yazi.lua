-- Integrate yazi file manager

---@type LazySpec
return {
    "mikavilpas/yazi.nvim",
    ---@type YaziConfig
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        keymaps = {
            show_help = "<f1>",
        },
    },
    keys = {
        { "<leader>-",  "<cmd>Yazi<cr>",     desc = "Open yazi at the current file" },
        { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory" },
    },
}
