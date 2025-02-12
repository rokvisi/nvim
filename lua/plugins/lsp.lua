return {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        "williamboman/mason.nvim",
        opts = {},
        lazy = false -- mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin is not recommended.
    },
    -- Types for LibUV library which is used for Nvim's event-loop.
    -- LibUV developed for the "luvit" project as the built-in uv module, but can be used in other Lua environments (nvim).
    {
        "Bilal2453/luvit-meta",
        lazy = true
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- Only load luvit types when the `vim.uv` word is found in the file.
                { path = "luvit-meta/library", words = { "vim%.uv" } },

                -- If you have files that only use types from a plugin, then those types won't be available in your workspace.
                -- To get around the above, you can pre-load those plugins with the library option.
                -- OR use the nvim-cmp, blink.cmp or coq_nvim completion source to get all available modules. (Doesn't work somehow)
                "lazy.nvim",
                "yazi.nvim",
                "snacks.nvim",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
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

            -- Disble eslint no-unused-vars globally.
            require 'lspconfig'.eslint.setup {
                settings = {
                    rulesCustomizations = {
                        ['@typescript-eslint/no-unused-vars'] = 'off'
                    }
                }
            }

            -- Can't configure clang_format (embedded in clangd) or clangd with LSPConfig.
            -- https://github.com/LazyVim/LazyVim/discussions/122#discussioncomment-4768884
            -- require 'lspconfig'.clang.setup { }
        end
    }
}
