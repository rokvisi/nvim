-- Better folding.

---@type LazySpec
return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    opts = {
        provider_selector = function(bufnr, filetype, buftype)
            --? Using 'lsp' as the first provider takes a long while to start working.
            return { "lsp", "indent" }
        end,
    },

    -- 'zR' and 'zM' commands change the foldlevel ufo provide openAllFolds/closeAllFolds to open/close all folds and keep foldlevel.
    keys = {
        { "zR", function() require("ufo").openAllFolds() end,  desc = "Open all folds" },
        { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    },
}
