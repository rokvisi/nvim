-- Language server configurations.

return {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    ---@type LazySpec
    {
        "williamboman/mason.nvim",
        opts = {},
        lazy = false -- mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin is not recommended.
    },

    ---@type LazySpec
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            ---@type LazySpec
            {
                'saghen/blink.cmp' -- IMPORTANT, must load blink before lspconfig.
            },
            ---@type LazySpec
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        -- Only load luvit types when the `vim.uv` word is found in the file.
                        -- Types for LibUV library which is used for Nvim's event-loop.
                        -- LibUV developed for the "luvit" project as the built-in uv module, but can be used in other Lua environments (nvim).
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },

                        -- If you have files that only use types from a plugin, then those types won't be available in your workspace.
                        -- To get around the above, you can pre-load those plugins with the library option.
                        -- OR use the nvim-cmp, blink.cmp or coq_nvim completion source to get all available modules. (Doesn't work somehow)
                        "lazy.nvim",
                        "yazi.nvim",
                        "snacks.nvim",
                    },
                },
            },
        }
    },

    ---@type LazySpec
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

                    -- Extend capabilities with folding.
                    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
                    default_capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }

                    -- Extend capabilities with autocomplete from 'blink.cmp'.
                    local capabilities = require('blink.cmp').get_lsp_capabilities(default_capabilities)

                    -- Attach keymaps
                    -- Maybe use the LSP Attach event instead?
                    -- vim.api.nvim_create_autocmd("LspAttach", {
                    --     callback = function(args)
                    --       local bufnr = args.buf
                    --       local client = vim.lsp.get_client_by_id(args.data.client_id)
                    --       if client.server_capabilities.completionProvider then
                    --         vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                    --       end
                    --       if client.server_capabilities.definitionProvider then
                    --         vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                    --       end
                    --     end,
                    --   })
                    local function on_attach(client, bufnr)
                        require("lsp-format").on_attach(client, bufnr)
                        require("lsp-keymaps").set_lsp_keymaps(bufnr)
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
