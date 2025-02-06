return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end
    },

    { "neovim/nvim-lspconfig" },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "svelte", "eslint", "gopls", "pyright" }
            })
            require("mason-lspconfig").setup_handlers({
                --default handler
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        on_attach = function(_, bufnr)
                            require("plugins.keymaps.lsp").set_lsp_keymaps(bufnr)
                        end
                    })
                end,
            })

            require 'lspconfig'.eslint.setup {
                settings = {
                    rulesCustomizations = {
                        ['@typescript-eslint/no-unused-vars'] = 'off'
                    }
                }
            }
        end
    }
}
