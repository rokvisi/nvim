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

        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            desc = "Autoformat on buffer write.",
            group = vim.api.nvim_create_augroup('FormatOnSave', {}),
            callback = function()
                require("utils").lsp_format()
            end
        })
    end,
}
