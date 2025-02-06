-- Autocomplete for command line mode
return {
    'gelguy/wilder.nvim',
    config = function()
        local wilder = require('wilder')
        wilder.setup({ modes = { ':', '/', '?' } })

        wilder.set_option('renderer', wilder.popupmenu_renderer(
            wilder.popupmenu_border_theme({
                highlighter = wilder.basic_highlighter(),
                min_width = '100%', -- minimum height of the popupmenu, can also be a number
                reverse = 0,        -- if 1, shows the candidates from bottom to top
            })
        ))
    end,
}
