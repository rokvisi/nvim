-- 'lsp_keymaps' module
return {
    set_lsp_keymaps = function(bufnr)
        -- LSP actions
        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[l]SP [h]over"
        })
        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[l]sp [a]ctions"
        })
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[l]sp [r]ename"
        })

        -- Use lsp-format created UserComand to format the buffer.
        -- vim.lsp.buf.format() breaks folds.
        vim.keymap.set('n', '<leader>lf', vim.cmd.Format, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[l]sp [f]ormat"
        })

        -- LSP go to definition/declaration
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[g]o to [d]efinition"
        })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[g]o to [D]eclaration"
        })

        -- Error diagnostics
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "open [e]rror diagnostics"
        })
    end
}
