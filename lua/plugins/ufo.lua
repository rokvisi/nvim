-- Better folding.

-- Custom text instead of '···' on folded lines.
local fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    -- local suffix = (' 󰁂 %d ···'):format(endLnum - lnum)
    local suffix = (' ··· (%d)'):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

---@type LazySpec
return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        'nvim-treesitter/nvim-treesitter',
    },
    event = "BufReadPost",
    -- init = function () end,
    opts = {
        fold_virt_text_handler = fold_virt_text_handler,
        provider_selector = function(bufnr, filetype, buftype)
            --? Using 'lsp' as the first provider takes a long while to start working.
            return { "lsp", "indent" }
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
