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

local function set_lsp_keymaps(client, bufnr)
    -- dd(client.name, client.capabilities)

    -- LSP actions
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[l]SP [h]over',
    })
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[l]sp [a]ctions',
    })
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[l]sp [r]ename',
    })
    vim.keymap.set('n', '<leader>lf', function()
        require("utils").lsp_format()
    end, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[l]sp [f]ormat',
    })

    -- LSP go to definition/declaration
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[g]o to [d]efinition',
    })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = '[g]o to [D]eclaration',
    })

    -- Error diagnostics
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = 'open [e]rror diagnostics',
    })
end

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

            -- Helper function to make client capabilities.
            local function make_client_capabilities()
                -- Get default client (neovim) capabilities.
                local client_capabilities = vim.lsp.protocol.make_client_capabilities()

                -- Extend client capabilities with folding.
                client_capabilities.textDocument.foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true
                }
                -- Extend client capabilities with autocomplete.
                client_capabilities = require('blink.cmp').get_lsp_capabilities(client_capabilities)

                return client_capabilities
            end

            -- Helper function to merge multiple on_attach functions.
            local function on_attach(client, bufnr)
                set_lsp_keymaps(client, bufnr)
            end

            --! If you use 'setup_handlers', make sure you don't also manually set up servers
            --! directly via `lspconfig` as this will cause servers to be set up more than once.
            require("mason-lspconfig").setup_handlers({
                --default handler that runs for all lanugage servers that are not explicitly specified AFTER THIS FUNCTION.
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = make_client_capabilities(),
                        on_attach = on_attach
                    })
                end,

                -- Disble eslint 'no-unused-vars' globally.
                ["eslint"] = function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = make_client_capabilities(),
                        on_attach = on_attach,
                        settings = {
                            rulesCustomizations = {
                                ['@typescript-eslint/no-unused-vars'] = 'off'
                            }
                        }
                    })
                end,

                -- Add "typescript-svelte-plugin" globally to the TypeScript language server.
                -- This adds support for Svelte's zero-effort type safety in TypeScript files.
                -- Does not intefere with non-Svelte projects (plugin auto-detects Svelte).
                -- https://svelte.dev/blog/zero-config-type-safety
                -- *IMPORTANT*: The plugin needs to be installed globally.
                -- *IMPORTANT*: The PATH may vary depending on the OS and Package Manager.
                ["ts_ls"] = function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = make_client_capabilities(),
                        on_attach = on_attach,
                        init_options = {
                            plugins = {
                                {
                                    name = "typescript-svelte-plugin",
                                    location = vim.fs.normalize(
                                        "$HOME/.bun/install/global/node_modules/typescript-svelte-plugin"
                                    ),
                                },
                            },
                        },
                    })
                end

                -- Can't configure clang_format (embedded in clangd) or clangd with LSPConfig.
                -- https://github.com/LazyVim/LazyVim/discussions/122#discussioncomment-4768884
                -- ["clang"] = function (server_name)
                --     require("lspconfig")[server_name].setup()
                -- end
            })
        end
    }
}
