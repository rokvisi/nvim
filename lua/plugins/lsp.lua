-- Language server configurations.

-- It's important that you set up the plugins in the following order:
-- 1. 'mason.nvim'
-- 2. 'mason-lspconfig.nvim'
-- 3. Setup servers via 'lspconfig'

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

---@type LazySpec
return {
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        "williamboman/mason.nvim",
        lazy = false, -- mason.nvim is optimized to load as little as possible during setup. Lazy-loading the plugin is not recommended.
    },
    -- Easily configure lanugage servers.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                'saghen/blink.cmp', -- IMPORTANT, must load blink before lspconfig.
            },
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
    -- Automatically configure all language servers installed by Mason.
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ts_ls", "svelte", "eslint" },
                automatic_installation = false, -- Don't automatically install servers which are set-up with lspconfig[server_name]
            })

            --! If you use 'setup_handlers', make sure you don't also manually set up servers
            --! directly via `lspconfig` as this will cause servers to be set up more than once.
            require("mason-lspconfig").setup_handlers({
                --default handler that runs for all lanugage servers that are not explicitly specified AFTER THIS FUNCTION.
                function(server_name)
                    -- Get default client (neovim) capabilities.
                    local client_capabilities = vim.lsp.protocol.make_client_capabilities()

                    -- Extend client capabilities with folding.
                    client_capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }

                    -- Extend client capabilities with autocomplete.
                    client_capabilities = require('blink.cmp').get_lsp_capabilities(client_capabilities)

                    -- Setup the server.
                    require("lspconfig")[server_name].setup({
                        capabilities = client_capabilities,

                        -- Runs after attaching the language server to the buffer.
                        on_attach = function(client, bufnr)
                            require("lsp-format").on_attach(client, bufnr)
                            require("lsp-keymaps").set_lsp_keymaps(bufnr)
                        end
                    })
                end,

                -- Disble eslint 'no-unused-vars' globally.
                ["eslint"] = function(server_name)
                    require('lspconfig')[server_name].setup({
                        settings = {
                            rulesCustomizations = {
                                ['@typescript-eslint/no-unused-vars'] = 'off'
                            }
                        }
                    })
                end,

                -- Can't configure clang_format (embedded in clangd) or clangd with LSPConfig.
                -- https://github.com/LazyVim/LazyVim/discussions/122#discussioncomment-4768884
                -- ["clang"] = function (server_name)
                --     require("lspconfig")[server_name].setup()
                -- end
            })
        end
    }
}
