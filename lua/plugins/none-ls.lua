-- Use formatters as lsp's to provide formatting and linting.

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    dependencies = "nvimtools/none-ls-extras.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.code_actions.refactoring,
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.gofumpt,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.clang_format,
            },
        })
        --? Currently Using lsp-format instead.
        -- vim.api.nvim_create_autocmd({ "BufWrite" }, {
        --     desc = "Autoformat on buffer write.",
        --     callback = function()
        --         -- Only format modified buffers.
        --         if vim.bo.modified == true then
        --             vim.lsp.buf.format();
        --             -- vim.cmd('lua vim.lsp.buf.format()')
        --         end
        --     end
        -- })
    end,
}
