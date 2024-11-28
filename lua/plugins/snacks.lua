-- Startup Dashboard.

return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        dashboard = {
            enabled = true,
            sections = {
                  {
                    section = "terminal",
                    -- cmd = "chafa C:/Users/Rokas/.config/nvim-dash.webp --format symbols --symbols vhalf --size 60x17 --stretch",
                    cmd = "chafa $HOME/.config/nvim-dash.webp --format symbols --symbols vhalf --size 60x17 --stretch",
                    height = 17,
                    padding = 1,
                  },
                  {
                    pane = 2,
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup" },
                  }
                
            },
        },
    },
  }
