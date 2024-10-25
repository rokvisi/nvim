-- Better startup screen for 'nvim'.
-- Includes recent projects and files.
-- Can press 'f' to open Telescope.
return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            shortcut_type = 'number',
            disable_move = true,
            config = {
                week_header = {
                    enable = true
                },
                footer = {},
                shortcut = {
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                }
            }
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

