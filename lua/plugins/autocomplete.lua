return {
    { 'hrsh7th/cmp-path' },
    {'L3MON4D3/LuaSnip'},
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'nvim_lsp_signature_help' }
                },
                window = {
                    completion = require("cmp").config.window.bordered(),
                    documentation = require("cmp").config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select)
                },
            })
        end
    }
}

