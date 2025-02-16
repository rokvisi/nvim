-- 'lsp_keymaps' module
return {
    set_lsp_keymaps = function(bufnr)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[G]o to [D]efinition"
        })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[G]o to [D]eclaration"
        })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[R]e[N]ame variable"
        })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[C]ode [A]ctions"
        })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "Show [E]rror diagnostic"
        })
        vim.keymap.set('n', '<leader>i', vim.lsp.buf.hover, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "LSP [I]nformation"
        })
    end
}
