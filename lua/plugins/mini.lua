return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        -- Extend and create a/i textobjects
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
        require('mini.ai').setup()

        -- Text edit operators
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-operators.md
        require('mini.operators').setup()

        -- Move any selection in any direction
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
        require('mini.move').setup()

        -- Fast and feature-rich surround actions
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
        require('mini.surround').setup()

        -- Minimal and fast autopairs for (), {}, [], '', "", ``
        -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
        require('mini.pairs').setup()
    end
}
