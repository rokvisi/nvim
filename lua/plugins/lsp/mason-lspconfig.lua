-- *AUTO* Configure (+attach) LSP Servers installed by Mason.

return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup()

        mason_lspconfig.setup_handlers {
            function (server_name)
                -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
                local capabilities = require('cmp_nvim_lsp').default_capabilities()
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities
                }
            end,

            -- For individual lsp configuration
            -- --------------------------------
            -- ['rust_analyzer'] = function()
                -- require('rust-tools').setup {}
            -- end
        }
    end
}