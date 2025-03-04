-- Show buffer names just like in VSCode.

local utils = require('utils')

local function svelte_name_formatter(buf)
    -- Substitutions:
    -- %1 - the last directory in the path
    -- %2 - filename + extension
    local patterns = {
        -- Root Page
        [".*/src/routes/%+page%.svelte$"] = "Root Page",
        [".*/src/routes/%+page%.([tj]s)$"] = "Root Page (u)",
        [".*/src/routes/%+page%.server%.([tj]s)$"] = "Root Page (s)",

        -- Root Layout
        [".*/src/routes/%+layout%.svelte$"] = "Root Layout",
        [".*/src/routes/%+layout%.([tj]s)$"] = "Root Layout (u)",
        [".*/src/routes/%+layout%.server%.([tj]s)$"] = "Root Layout (s)",

        -- Root Error and fallback
        [".*/src/routes/%+error%.svelte$"] = "Root Error",
        [".*/src/error%.html$"] = "Fallback Error",

        -- Substitutions Page
        [".*/src/routes/(.+)/%+page%.svelte$"] = "/%1 Page",
        [".*/src/routes/(.+)/%+page%.([tj]s)$"] = "/%1 (u)",
        [".*/src/routes/(.+)/%+page%.server%.([tj]s)$"] = "/%1 (s)",

        -- Substitutions Layout
        [".*/src/routes/(.+)/%+layout%.svelte$"] = "/%1 Layout",
        [".*/src/routes/(.+)/%+layout%.([tj]s)$"] = "/%1 Layout (u)",
        [".*/src/routes/(.+)/%+layout%.server%.([tj]s)$"] = "/%1 Layout (s)",

        -- Substitutions Error and endpoint
        [".*/src/routes/(.+)/%+error%.svelte$"] = "/%1 Error",
        [".*/src/routes/(.+)/%+server%.([tj]s)$"] = "/%1 Endpoint",

        -- Components
        [".*/src/(.*/)?([^+][^/]*)%.svelte$"] = "%2"
    }

    local path = vim.fs.normalize(buf.path)
    local filename = buf.name
    local last_dir_in_path = utils.paths.get_last_dir_in_path(path)

    -- Iterate over all patterns.
    for pattern, template in pairs(patterns) do
        local match = path:match(pattern)

        -- Match found.
        if match then
            local substituted = template
            substituted = substituted:gsub("%%1", last_dir_in_path)
            substituted = substituted:gsub("%%2", filename)

            return substituted
        end
    end

    -- Fallback to the filename.
    return filename
end

---@type LazySpec
return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            truncate_names = false, -- Don't truncate buffer names.

            -- 'buf' contains:
            -- name: string                    - the basename of the active file
            -- path : string                   - the full path of the active file
            -- bufnr: int                      - the number of the active buffer
            -- buffers (tabs only): table(int) - the numbers of the buffers in the tab
            -- tabnr (tabs only): int          - the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
            name_formatter = function(buf)
                -- Any form of printing gets called a million times each second. Figure out what is happening.
                if utils.is_svelte_project() then
                    return svelte_name_formatter(buf)
                end

                return buf.name
            end

        }
    }
}
