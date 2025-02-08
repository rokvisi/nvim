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
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "svelte", "eslint", "gopls", "pyright" }
            })
            require("mason-lspconfig").setup_handlers({
                --default handler that runs for all lanugage servers.
                function(server_name)
                    local server = require("lspconfig")[server_name]

                    -- Add autocomplete capabilities from 'blink.cmp'.
                    local capabilities = require('blink.cmp').get_lsp_capabilities()

                    -- Attach keymaps
                    local function on_attach(_, bufnr)
                        require("plugins.keymaps.lsp").set_lsp_keymaps(bufnr)
                    end

                    server.setup({
                        capabilities = capabilities,
                        on_attach = on_attach
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
