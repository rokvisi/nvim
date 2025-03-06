-- Use formatters as lsp's to provide formatting and linting.

---@type LazySpec
return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls      = require("null-ls")

        local formatting   = require("null-ls").builtins.formatting   -- Formatting sources
        local diagnostics  = require("null-ls").builtins.diagnostics  -- Diagnostics sources
        local code_actions = require("null-ls").builtins.code_actions -- Code actions sources
        local completion   = require("null-ls").builtins.completion   -- Completion sources
        local hover        = require("null-ls").builtins.hover        -- Hover sources

        null_ls.setup({
            sources = {
                formatting.stylua,
                formatting.prettierd.with({
                    -- For js/ts files without a .prettierrc.json file, use the default config.
                    env = {
                        PRETTIERD_DEFAULT_CONFIG = vim.fs.normalize(vim.fn.stdpath("config") .. "/.prettierrc.json"),
                    },
                }),
                formatting.clang_format,
                code_actions.refactoring,
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
