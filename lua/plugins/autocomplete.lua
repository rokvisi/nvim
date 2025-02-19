-- Autocompletion

---@type LazySpec
return {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets', -- optional: provides snippets for the snippet source
    version = '*',                                 -- use a release tag to download pre-built binaries

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            menu = {
                border = 'single',
                draw = {
                    columns = {
                        { "label",     "label_description", gap = 1 },
                        { "kind_icon", "kind",              gap = 1, "source_name" }
                    },
                    treesitter = { "lsp" },
                    -- components = {
                    --     custom = {
                    --         text = function(ctx)
                    --             return "a" .. ctx.label_description .. "a"
                    --         end
                    --     }
                    -- }
                }
            },
            ghost_text = {
                enabled = true,
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = 'single'
                }
            },
            list = {
                selection = {
                    -- Don't automatically select the first option in cmdline completions.
                    -- preselect = false
                    preselect = function(ctx) return ctx.mode ~= 'cmdline' end
                }
            }
        },

        signature = {
            enabled = true,
            window = {
                border = 'single'
            }
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        -- snippets = {
        --     score_offset = -10,
        -- },

        sources = {
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            -- TODO: Maybe enable omnifunc source?

            -- default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            default = function(ctx)
                local all_sources = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' }
                local exclude = require('utils').table.exclude

                -- Ideas:
                -- * Exlude snippets from all: [string, object, object_type] nodes.

                -- Exclude lazydev completions in non-lua files.
                if vim.bo.filetype ~= "lua" then
                    all_sources = exclude(all_sources, { 'lazydev' })
                end

                -- Svelte customizations
                if vim.bo.filetype == 'svelte' then
                    -- Get the AST node at the cursor.
                    local cursor_node = vim.treesitter.get_node({ lang = "svelte", ignore_injections = false })
                    local cursor_node_type = cursor_node:type()

                    -- All 'string_fragment' nodes are parented by a 'string' node.
                    if cursor_node_type == 'string_fragment' then
                        cursor_node = cursor_node:parent()
                        cursor_node_type = cursor_node:type()
                    end

                    -- Check if the parent of the string node is an import statement.
                    local parent_exists, parent_node = pcall(cursor_node, cursor_node.parent) -- TODO: May error
                    if parent_exists and parent_node:type() == 'import_statement' then
                        return { 'lsp' }
                    end

                    -- Check if the node is a string node.
                    if cursor_node_type == 'string' then
                        return exclude(all_sources, { 'snippets' })
                    end

                    -- Check if the node is inside an object.
                    if cursor_node_type == 'object' or cursor_node_type == "object_type" then
                        return { 'lsp', 'buffer' }
                    end
                end

                -- In comment nodes - only use the 'buffer' source.
                -- if vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                --     return { 'buffer' }
                -- end

                -- -- In raw text nodes - don't use the 'snippets' source.
                -- if vim.tbl_contains({ 'svelte_raw_text', 'raw_text' }, node:type()) then
                --     local sources = exclude(all_sources, { 'snippets' })

                --     -- Additionally in svelte files - remove path source, since paths are provided by the LSP.
                --     if vim.bo.filetype == "svelte" then
                --         return exclude(sources, { 'path' })
                --     end

                --     return sources
                -- end

                -- Fallback - use all sources.
                return all_sources
            end,

            providers = {
                -- Lazydev completion source for require statements and module annotations in neovim configurations.
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
                },
            },
        },

        keymap = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            preset = 'none',

            ['<CR>'] = { 'accept', 'fallback' },
            ['<C-space>'] = { 'show', 'hide', 'fallback' },

            -- If in snippet - jump to next placeholder; otherwise, jump to next source.
            ['<Tab>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.snippet_forward()
                    else
                        return cmp.select_next()
                    end
                end,
                'fallback'
            },
            -- If in snippet - jump to previous placeholder; otherwise, jump to previous source.
            ['<S-Tab>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.snippet_backward()
                    else
                        return cmp.select_prev()
                    end
                end, 'fallback'
            },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },

            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
    },
    opts_extend = { "sources.default" }
}
