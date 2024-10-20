-- Used for installing treesitter parsers for neovim treesitter core.

return {
    'nvim-treesitter/nvim-treesitter',
    opts = {
        
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'html', 'css', 'javascript', 'typescript', 'json', 'yaml', 'svelte', 'vue', 'tsx', 'python', 'rust', 'cpp', 'graphql' },
            auto_install = true,
            highlight = {
                enable = true,
            },
        })
    end
}