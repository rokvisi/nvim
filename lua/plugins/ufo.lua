-- Better folding.

---@type LazySpec
return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        'nvim-treesitter/nvim-treesitter',
    },
    event = "BufReadPost",
    opts = {

        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            -- Custom text instead of '···' on folded lines
            -- https://github.com/kevinhwang91/nvim-ufo#customize-fold-text
            table.insert(virtText, { (' 󰇘 [%d lines]'):format(endLnum - lnum), 'MoreMsg' })
            return virtText
        end,
        provider_selector = function(bufnr, filetype, buftype)
            --? Using 'lsp' as the first provider takes a long while to start working.
            -- return { "lsp", "indent" }
            return { "treesitter", "indent" }
        end,
    },
    -- 'zR' and 'zM' commands change the foldlevel ufo provide openAllFolds/closeAllFolds to open/close all folds and keep foldlevel.
    keys = {
        { "zR", function() require("ufo").openAllFolds() end,         desc = "Open all folds" },
        { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
        { "zM", function() require("ufo").closeAllFolds() end,        desc = "Close all folds" },
        { "zm", function() require("ufo").closeFoldsWith() end,       desc = "Close all folds with" },
    },
}
